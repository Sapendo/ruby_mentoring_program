# frozen_string_literal: true

require 'logger'

# Add new user
class User
  def initialize(name, age)
    logger = Logger.new('log_file.log')
    @name = name
    @age = age
    logger.info("User name: #{name}, user age: #{age}")
  end
end
