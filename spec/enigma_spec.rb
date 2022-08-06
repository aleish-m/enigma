require_relative 'spec_helper'
require './lib/enigma'

describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  describe 'Initialize' do
    it 'Enigma exists' do
      expect(@enigma).to be_an_instance_of Enigma
    end
    it 'Enigma has a list of all incodeable characters' do
      expect(@enigma.characters).to eq ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    end

    it 'has no incoming message, key or date when created when created' do
      expect(@enigma.message).to eq ''
      expect(@enigma.key).to eq ''
      expect(@enigma.date).to eq ''
    end
  end

  describe 'encrypt' do
    it 'adds message to be encrypted' do
      @enigma.encrypt('hello world', '02715', '040895')
      expect(@enigma.message).to eq 'hello world'
    end

    it 'adds a key to use for encryption' do
      @enigma.encrypt('hello world', '02715', '040895')

      expect(@enigma.key).to eq '02715'
    end

    it 'has a creates a default key if none given for encryption' do
      random_number = Random.new(1234).to_s
      @enigma.encrypt('hello world', random_number)
      allow(@enigma).to receive(:generate_key).and_return(random_number)
      expect(@enigma.key).to eq random_number
    end
    
    it 'adds a date to use for encryption' do
      @enigma.encrypt('hello world', '02715', '040895')
      
      expect(@enigma.date).to eq '040895'
    end

    it 'defaults to todays date (ddmmyy) if none given for encryption' do
      @enigma.encrypt('hello world')

      allow(@enigma).to receive(:generate_date).and_return('060822')
      expect(@enigma.date).to eq '060822'
    end
  
    it 'creates shift values from the key' do
      @enigma.encrypt('hello world', '02715', '040895')
      expect(@enigma.key_shift).to eq({A: 02, B: 27, C: 71, D: 15})
    end

    it 'creates shift values from the date' do
      @enigma.encrypt('hello world', '02715', '040895')
      expect(@enigma.date_shift).to eq({A: 1, B: 0, C: 2, D: 5})
    end

    it 'creates total shift values' do
      @enigma.encrypt('hello world', '02715', '040895')
      expect(@enigma.total_shift).to eq({A: 3, B: 27, C: 73, D: 20})
    end

    it 'creates a shifted message' do
      @enigma.encrypt('hello! world', '02715', '040895')
      expect(@enigma.encrypt_message).to eq('keder! ohulw')
    end

    it 'encrypts text' do
      expected_hash = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.encrypt('hello world', '02715', '040895')).to eq expected_hash
    end
  end
end
