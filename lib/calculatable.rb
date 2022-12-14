module Calculatable
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

  def total_shift_value
    key_shift.merge(date_shift) { |offset, key_value, date_value| key_value + date_value }
  end
end
