require 'date'
class Enigma
  attr_reader :characters

  def initialize
    @characters = ('a'..'z').to_a << ' '
  end

  def incoming(incoming_phrase, incoming_key, incoming_date)
    { phrase: incoming_phrase, key: incoming_key, date: incoming_date }
  end
end
