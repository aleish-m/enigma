module Shiftable
  def message_array
    @message.chars
  end

  def encryption_array
    @encryption.chars
  end

  def shifting_hash
    { 0 => :A, 1 => :B, 2 => :C, 3 => :D }
  end

  def shift_count(turn)
    turn += 1 if turn < 4
    turn = 0 if turn == 4
    turn
  end

  def new_character(current_index, turn, type)
    if type == 'encrypt'
      @characters[encrypt_index(current_index, turn)]
    elsif type == 'decrypt'
      @characters[dencrypt_index(current_index, turn)]
    end
  end

  def create_shifted_message(array, type)
    turn = 3
    array.map do |character|
      turn = shift_count(turn)
      if !@characters.include?(character)
        character
      else
        current_index = @characters.find_index(character)
        new_character(current_index, turn, type)
      end
    end
  end

  def encrypt_index(current_index, turn)
    encrypt_index = current_index + total_shift_value[shifting_hash[turn]]
    encrypt_index = encrypt_index % @characters.count if encrypt_index >= @characters.count
    encrypt_index
  end

  def dencrypt_index(current_index, turn)
    dencrypt_index = current_index - total_shift_value[shifting_hash[turn]]
    dencrypt_index = dencrypt_index % @characters.count if dencrypt_index <= @characters.count
    dencrypt_index
  end
end
