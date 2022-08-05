require 'date'
class Enigma
  
  def incoming(incoming_phrase, incoming_key, incoming_date)
    {phrase: incoming_phrase, key: incoming_key, date: incoming_date}
  end
end