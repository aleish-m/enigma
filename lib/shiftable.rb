module Shiftable

  def generate_key
   rand.to_s[2..6]
  end

  def generate_date
    Date.today.strftime('%d%m%y')
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
    dencrypt_msg = array.map do |character|
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
    encrypt_index = current_index + total_shift[shifting_hash[turn]]
    encrypt_index = encrypt_index % @characters.count if encrypt_index >= @characters.count
    encrypt_index
  end

  def dencrypt_index(current_index, turn)
    dencrypt_index = current_index - total_shift[shifting_hash[turn]]
    dencrypt_index = dencrypt_index % @characters.count if dencrypt_index <= @characters.count
    dencrypt_index
  end
  
end
