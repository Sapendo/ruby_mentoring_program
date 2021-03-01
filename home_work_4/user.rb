# frozen_string_literal: true

require './logger'

# Add new user
class User
  def initialize(name, age)
    @name = name
    @age = age
    $Log.info("User name: #{name}, user age: #{age}")
  end
end
