# frozen_string_literal: true
require "spec_helper"

RSpec.describe Types do

  describe "Types::URI" do
    subject(:type)        { Types::URI }
    let(:valid_value)     { "amqp://" }
    let(:invalid_value)   { "silly" }

    it 'a correct value is valid' do
      expect(type[valid_value]).to be_truthy
    end

    it 'an incorrect value is not valid' do
      # binding.pry
      expect{type[invalid_value]}.to raise_error Dry::Types::ConstraintError
    end
  end


  describe "Types::PositiveInteger" do
    subject(:type)        { Types::PositiveInteger }
    let(:valid_value)     {  0 }
    let(:invalid_value)   { -1 }

    it 'a correct value is valid' do
      expect(type[valid_value]).to be_truthy
    end

    it 'an incorrect value is not valid' do
      expect{type[invalid_value]}.to raise_error Dry::Types::ConstraintError
    end
  end

  describe "Types::AmqpChannelType" do
    subject(:type)            { Types::AmqpChannelType }
    let(:valid_value_key)     { :queue }
    let(:valid_value_string)  { "routing_key" }
    let(:invalid_value_key)   { :silly }

    it 'a correct value is valid' do
      expect(type[valid_value_key]).to be_truthy
    end

    it 'an incorrect value is not valid' do
      expect{type[invalid_value_key]}.to raise_error Dry::Types::ConstraintError
    end

    it 'coerces a correct value string type to symbol type' do
      expect(type[valid_value_string]).to be_truthy
    end
  end

end
