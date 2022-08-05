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

    it 'adds a date to use for encryption' do
      @enigma.encrypt('hello world', '02715', '040895')

      expect(@enigma.date).to eq '040895'
    end
    
    # it 'creates an incoming hash and stores it' do
    #   expected_hash = {
    #     phrase: 'hello world',
    #     key: '02715',
    #     date: '040895'
    #   }

    #   expect(@enigma.incoming('hello world', '02715', '040895')).to eq expected_hash
    # end

    it 'creates shift values from the key' do
      @enigma.encrypt('hello world', '02715', '040895')

      expect(@enigma.key_shift).to eq({A: 02, B: 27, C: 71, D: 15})
    end

    xit 'encrypts text' do
      expected_hash = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }

      expect(@enigma.encrypt('hello world', '02715', '040895')).to eq expected_hash
    end
  end
end
