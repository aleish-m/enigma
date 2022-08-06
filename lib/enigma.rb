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

  def key_shift
    {A: @key[0..1].to_i, B: @key[1..2].to_i, C: @key[2..3].to_i, D: @key[3..4].to_i}
  end


end
