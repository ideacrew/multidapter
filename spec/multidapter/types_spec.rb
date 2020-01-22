# frozen_string_literal: true
require "spec_helper"

RSpec.describe Types do

  describe "Types::Uri" do
    subject(:type)        { Types::Uri }
    let(:valid_value)     { "amqp://" }
    let(:invalid_value)   { "silly uri" }

    it 'a correct value is valid' do
      expect(type[valid_value]).to be_truthy
    end

    it 'an incorrect value is not valid' do
      expect{type[invalid_value]}.to raise_error URI::InvalidURIError
    end
  end


  describe "Types::PositiveInteger" do
    subject(:type)            { Types::PositiveInteger }
    let(:valid_value)         {  0 }
    let(:invalid_value)       { -1 }
    let(:valid_value_string)  { "2".freeze }

    it 'a correct value is valid' do
      expect(type[valid_value]).to be_truthy
    end

    it 'an incorrect value is not valid' do
      expect{type[invalid_value]}.to raise_error Dry::Types::ConstraintError
    end

    it 'coerces a correct value string type to integer type' do
      expect(type[valid_value_string]).to be_truthy
    end
  end

  describe "Types::SecuritySchemeType" do
    subject(:type)            { Types::SecuritySchemeType }
    let(:valid_value)         { :symmetric_encryption }
    let(:invalid_value)       { :unsecure }
    let(:valid_value_string)  { "x509".freeze }

    it 'a correct value is valid' do
      expect(type[valid_value]).to be_truthy
    end

    it 'an incorrect value is not valid' do
      expect{type[invalid_value]}.to raise_error Dry::Types::ConstraintError
    end

    it 'coerces a correct value string type to integer type' do
      expect(type[valid_value_string]).to be_truthy
    end
  end
end
