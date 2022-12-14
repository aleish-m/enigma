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

  describe 'accepts information' do
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
    end

    it 'can recive only message and date and creates a key' do
      enigma_1 = Enigma.new
      enigma_1.encrypt('hello world', '040895')

      allow(enigma_1).to receive(:key).and_return('12345')
      expect(enigma_1.date).to eq('040895')
      expect(enigma_1.key).to eq('12345')

    end

  end

  describe 'it has shifts' do 
    before :each do
      @enigma.encrypt('hello world', '02715', '040895')
    end

    it 'creates shift values from the key' do
      expect(@enigma.key_shift).to eq({A: 02, B: 27, C: 71, D: 15})
    end

    it 'creates shift values from the date' do
      expect(@enigma.date_shift).to eq({A: 1, B: 0, C: 2, D: 5})
    end

    it 'creates total shift values' do
      expect(@enigma.total_shift_value).to eq({A: 3, B: 27, C: 73, D: 20})
    end
  end

  describe 'it encripts message' do 
    before :each do
      @enigma.encrypt('hello world!', '02715', '040895')
    end
    
    it 'has creates a message array' do
      expect(@enigma.message_array).to eq(["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "!"])
    end

    it 'creates a shifted message' do
      expect(@enigma.encrypted_message).to eq('keder ohulw!')
    end

    it 'encrypts text' do
      expected_hash = {
        encryption: 'keder ohulw!',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.encrypt('hello world!', '02715', '040895')).to eq(expected_hash)
    end

    it 'encrypts text when no date or key are provided' do
      allow(Date).to receive(:today).and_return(Date.parse("2022-8-08"))
      allow(@enigma).to receive(:rand).and_return(0.7891011)
      expected_hash = {
        encryption: 'jsczqnnbtzv!',
        key: '78910',
        date: '080822'
      }
      expect(@enigma.encrypt('hello world!')).to eq(expected_hash)
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
        decryption: "hello world!",
        key: "02715",
        date: "040895"
      }
      expect(@enigma.decrypt("keder ohulw!", "02715", "040895")).to eq(expected_hash)
    end

    it 'makes a decrypts even if no date is provided' do
      allow(Date).to receive(:today).and_return(Date.parse("2022-8-08"))
      expected_hash = {
        decryption: "hello world!",
        key: "02715",
        date: "080822"
      }
      expect(@enigma.decrypt("okjdvfugyrb!", "02715")).to eq(expected_hash)
    end
  end

  describe 'Command Line Interface Helpers' do
    it 'shift_type - encrypt' do
      expected_hash = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
      expect(@enigma.shift_type('encrypt', 'hello world', '02715', '040895' )).to eq (expected_hash)
    end

    it 'shift_type - decrypt' do
      expected_hash = {
        decryption: "hello world!",
        key: "02715",
        date: "040895"
      }
      expect(@enigma.shift_type('decrypt', "keder ohulw!", "02715", "040895")).to eq (expected_hash)
    end

    it 'Command line provides feeadback to User' do
      allow(@enigma).to receive(:date).and_return('040822')
      allow(@enigma).to receive(:key).and_return('12345')
      expect(@enigma.status_message('encrypted.txt')).to eq("Created 'encrypted.txt' with the key 12345 and the date 040822")
    end
  end
end