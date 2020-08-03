require 'rspec'
require 'date'

RSpec.describe 'Mock' do


    it 'when called correctly' do
      # given
      mock = double("someThingy")
      expected = 'Some Freaky Mock'
      expect(mock).to receive(:getName).and_return(expected)

      # when
      actual = mock.getName();

      # then
      expect(actual).to eq(expected)
    end

    it 'mock not called' do
      # given
      mock = double("someThingy")
      expected = 'Some Freaky Mock'
      expect(mock).to receive(:getName).and_return(expected)

      # when
      # actual = mock.getName();

      # then
      # expect(actual).to eq(expected)
    end

    it 'called with wrong params' do
      # given
      mock = double("someThingy")
      expected = 'Some Freaky Mock'
      expect(mock).to (receive(:getName).with('someParam')).and_return(expected)

      # when
      actual = mock.getName('someOtherParam');

      # then
      # expect(actual).to eq(expected)
    end

  end