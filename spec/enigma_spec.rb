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
  end

  describe 'encrypt' do
    it 'creates an incoming hash' do
      expected_hash = {
        phrase: 'hello world',
        key: '02715',
        date: '040895'
      }

      expect(@enigma.incoming('hello world', '02715', '040895')).to eq expected_hash
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
