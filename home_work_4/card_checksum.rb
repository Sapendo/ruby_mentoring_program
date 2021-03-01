# frozen_string_literal: true

require './logger'

# The class accept card number and check it checksum
class CardChecksum
  def run_card_validation(card_number)
    $Log.info("User's card namber: #{card_number}")
    @card_number = clean_card_number(card_number)
    checksum = get_checksum(@card_number)  
    checksum_validation(checksum)
  end

  private

  def clean_card_number(card_number)
    card_number.gsub(/\D/, '')
  end

  def get_checksum(card_number)
    card_number = card_number.chars.map(&:to_i)
    (0...card_number.length).step(2) do |num|
      card_number[num] = (card_number[num] * 2).divmod(10).sum
    end
    card_number.sum
  end

  def checksum_validation(checksum)
    card_number = transform_to_output_view(@card_number)
    raise StandardError, "check unsuccessful for #{card_number}" unless (checksum % 10).zero?

    $Log.info("Checksum success")
    "check successful for #{card_number}"

  end

  def transform_to_output_view(card_number)
    card_number.gsub(/(?<chank>\d{4})/, '\k<chank>-').gsub(/-$/, '')
  end
end
