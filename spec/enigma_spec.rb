require_relative 'spec_helper'
require './lib/enigma'

describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  describe 'Initialize' do
    it 'Enigma exists' do
      expect(@enigma).to be_an_instance_of(Enigma)
    end
    it 'Enigma has a list of all incodeable characters' do
      expect(@enigma.characters).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "])
    end

    it 'has no incoming message, key or date when created when created' do
      expect(@enigma.message).to eq('')
      expect(@enigma.key).to eq('')
      expect(@enigma.date).to eq('')
    end
  end

  describe 'encrypt' do
    before :each do
      @enigma.encrypt('hello world', '02715', '040895')
    end
    it 'adds message to be encrypted' do
      expect(@enigma.message).to eq('hello world')
    end

    it 'adds a key to use for encryption' do

      expect(@enigma.key).to eq('02715')
    end

    it 'has a creates a default key if none given for encryption' do
      allow(@enigma).to receive(:rand).and_return('0.12345')
      expect(@enigma.generate_key).to eq('12345')
    end
    
    it 'adds a date to use for encryption' do
      
      expect(@enigma.date).to eq('040895')
    end

    it 'defaults to todays date (ddmmyy) if none given for encryption' do
      enigma_1 = Enigma.new
      enigma_1.encrypt('hello world')

      allow(Date).to receive(:today).and_return(Date.parse("2022-8-06"))
      expect(enigma_1.generate_date).to eq("060822")

      # expect(@enigma.generate_date).to eq( Date.today.strftime('%d%m%y'))
    end
  
    it 'creates shift values from the key' do
      expect(@enigma.key_shift).to eq({A: 02, B: 27, C: 71, D: 15})
    end

    it 'creates shift values from the date' do
      expect(@enigma.date_shift).to eq({A: 1, B: 0, C: 2, D: 5})
    end

    it 'creates total shift values' do
      expect(@enigma.total_shift).to eq({A: 3, B: 27, C: 73, D: 20})
    end

    it 'creates a shifted message' do
      expect(@enigma.encrypted_message).to eq('keder ohulw')
    end

    it 'encrypts text' do
      expected_hash = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.encrypt('hello world', '02715', '040895')).to eq(expected_hash)
    end
  end

  describe 'decrypt' do 
    before :each do 
      @enigma.decrypt("keder ohulw", "02715", "040895")
    end

    it 'has a encripted message' do
      expect(@enigma.encryption).to eq("keder ohulw")
    end

    it 'has creates an encripted message array' do
      expect(@enigma.encryption_array).to eq(["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"])
    end

    it 'has a encripted message' do
      expect(@enigma.encryption).to eq("keder ohulw")
    end

    it 'finds the decrypted message' do
      expect(@enigma.dencrypted_message).to eq("hello world")
    end

    it 'makes a decryption hash' do
      expected_hash = {
        decryption: "hello world",
        key: "02715",
        date: "040895"
      }
      expect(@enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected_hash)
    end
  end
end
