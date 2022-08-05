require 'date'
class Enigma
  attr_reader :characters, :message, :key, :date

  def initialize
    @characters = ('a'..'z').to_a << ' '
    @message = ''
    @key = ''
    @date = ''
  end


  def encrypt(incoming_phrase, incoming_key, incoming_date)
    @message = incoming_phrase
    @key = incoming_key
    @date = incoming_date
  end
  # def incoming(incoming_phrase, incoming_key, incoming_date)
  #   {phrase: incoming_phrase, key: incoming_key, date: incoming_date}
  # end
end
