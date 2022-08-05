require './lib/enigma'

describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  describe 'Initalize' do
    it 'Enigma exists' do
      expect(@enigma).to be_an_instance_of Enigma
    end
  end
end