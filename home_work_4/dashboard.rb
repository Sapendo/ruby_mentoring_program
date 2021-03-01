# frozen_string_literal: true

require './validation'
require './user'
require './card_checksum'
require './logger'

# The main class which union two separate classes like User and Checksum.
# As main class it make dicision to create the appropriate class or
# throw the appropriate error.
class Dashboard
  include Validation
  NAME_PATTERN = Regexp.new(/[A-Za-z]{3,}/)
  CARD_PATTERN = Regexp.new(/^((\d{4}[ -]){3}|(\d){12})\d{4}$/)
  DIGITAL_PATTERN = Regexp.new(/^[\d -]+$/)

  def user_introduction
    puts 'Please introduce yourself'
    get_name
    get_age
  end

  def name_validation(name)
    validate_by_regexp(name, NAME_PATTERN, 'Name must contains letters only and be more than 2 characters.')
    name
  end

  def age_validation(age)
    raise TypeError, "Age must contains numbers only." unless age.match?(/\d+/)
    raise RangeError, "Also your age must between 13 and 119" unless age.to_i.between?(13, 120)
    age
  end

  def add_user
    @user = User.new(@name, @age)
  end

  def card_checksum
    puts 'Please input your card number and press enter'
    begin
      @card_number = card_validation(gets.chomp)
    rescue RegexpError => err
      $Log.error("invalid card number #{err}")
      puts "Oops! Your make mistake? #{err}"
      puts "So let's try again)"
      retry
    end
    card_checksum = CardChecksum.new
    begin
      puts card_checksum.run_card_validation(@card_number)      
    rescue StandardError => err
      puts err
    end
  end

  def card_validation(card_number)
    digital_validation(card_number)
    pattern_validation(card_number)
    card_number
  end

  def digital_validation(card_number)
    has_letters_error_msg = 'Your card should not contains letters.'
    validate_by_regexp(card_number, DIGITAL_PATTERN, has_letters_error_msg)
  end

  def pattern_validation(card_number)
    pattern_error_msg = <<-HEREDOC
    Your card number do not match to patten
      Please use one of next patten:
      1. XXXX-XXXX-XXXX-XXXX
      2. XXXX XXXX XXXX XXXX
      3. XXXXXXXXXXXXXXXX'
    HEREDOC
    validate_by_regexp(card_number, CARD_PATTERN, pattern_error_msg)
  end

  private

  def get_name
    begin
      puts 'What is your name?'
      @name = name_validation(gets.chomp)
    rescue StandardError => err
      $Log.error("inappropriate name #{err}")
      puts "Oops! Your make mistake? #{err}"
      puts "So let's try again)"
      retry
    end
  end

  def get_age
    begin
      puts 'How old are you?'
      @age = age_validation(gets.chomp)
    rescue RangeError => err
      $Log.error("age out of range #{err}")
      abort "Oops! #{err}"
    rescue TypeError => err
      $Log.error("incorrect input for age #{err}")
      puts "Oops! #{err}"
      puts "So let's try again)"
      retry
    end
  end
end
