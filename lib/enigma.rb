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
    { A: @key[0..1].to_i, B: @key[1..2].to_i, C: @key[2..3].to_i, D: @key[3..4].to_i }
  end

  def date_shift
    date_code = (@date.to_i**2).to_s[-4..-1]
    { A: date_code[0].to_i, B: date_code[1].to_i, C: date_code[2].to_i, D: date_code[3].to_i }
  end

  def total_shift
    key_shift.merge(date_shift) { |offset, key_value, date_value| key_value + date_value }
  end

  def message_array
    @message.chars.each_slice(4).to_a
  end

  def shift_message
    shifted_array = []
    shifting_hash = {0 => :A, 1 => :B, 2 => :C, 3 => :D}
    message_array.each do |grouping|
    shift = 0
      grouping. each do |character|
        if !@characters.include?(character)
          shifted_array << character
          shift += 1
        else
          character_index = grouping.find_index(character)
          current_index = @characters.find_index(character)
          # require "pry"; binding.pry
          encrypt_index = current_index + total_shift[shifting_hash[shift]]
          if encrypt_index <= @characters.count
            shifted_array << @characters[encrypt_index]
            shift += 1
          else 
            encrypt_index = encrypt_index % @characters.count
            # require "pry"; binding.pry
            shifted_array << @characters[encrypt_index]
            shift += 1
          end
        end
      end
    end
    shifted_array.join
  end
end
