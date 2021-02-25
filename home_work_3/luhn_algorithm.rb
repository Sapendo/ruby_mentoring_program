# frozen_string_literal: true

def card_validation(card_number)
  pattern_validation(card_number)
  only_numbers = clean_card_number(card_number)
  final_sum = get_final_sum(only_numbers)
  final_sum_validation(final_sum, card_number)
end

def pattern_validation(number)
  error_msg = <<-HEREDOC
    Your card number do not match to patten
      Please use one of next patten:
      1. XXXX-XXXX-XXXX-XXXX
      2. XXXX XXXX XXXX XXXX
      3. XXXXXXXXXXXXXXXX'
  HEREDOC

  raise ArgumentError, error_msg unless number.match?(/^((\d{4}[ -]){3}|(\d){12})\d{4}$/)
end

def clean_card_number(card_number)
  card_number.gsub(/[ -]/, '')
end

def get_final_sum(card_number)
  card_number.chars.each_with_index.reduce(0) do |acc, element|
    chunk_of_number = element[0].to_i
    index = element[1]
    acc + (index.even? ? calculate_element(chunk_of_number) : chunk_of_number)
  end
end

def calculate_element(number)
  number * 2 > 9 ? number * 2 - 9 : number * 2
end

def final_sum_validation(final_sum, card_number)
  raise StandardError, "check unsuccessful for #{card_number}" unless (final_sum % 10).zero?

  "check successful for #{card_number}"
end

puts 'Please input your card number and press enter'
card_number = gets.chomp
puts card_validation(card_number)
