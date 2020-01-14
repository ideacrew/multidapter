# frozen_string_literal: true
require "spec_helper"

RSpec.describe Types do

  describe "Types::Amqp::ChannelType" do
    subject(:type)            { Types::Amqp::ChannelType }
    let(:valid_value_key)     { :queue }
    let(:valid_value_string)  { "routing_key".freeze }
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

  describe "Types::Amqp::ExchangeType" do
    subject(:type)            { Types::Amqp::ExchangeType }
    let(:valid_value_key)     { :topic }
    let(:valid_value_string)  { "direct".freeze }
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


  describe "Types::Amqp::MessageDeliveryMode" do
    subject(:type)            { Types::Amqp::MessageDeliveryMode }
    let(:valid_value_key)     { 1 }
    let(:valid_value_string)  { "2".freeze }
    let(:invalid_value_key)   { 3 }

    it 'a correct value is valid' do
      expect(type[valid_value_key]).to be_truthy
    end

    it 'an incorrect value is not valid' do
      expect{type[invalid_value_key]}.to raise_error Dry::Types::ConstraintError
    end

    it 'coerces a correct value string type to integer type' do
      expect(type[valid_value_string]).to be_truthy
    end
  end


end
