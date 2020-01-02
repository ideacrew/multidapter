# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Protocols::AmqpNode do

  let(:amqp_uri)    { "amqp://localhost" }
  let(:options)     { {} }

  context "with default options" do
    it "should return a Bunny::Session connection object" do
      # binding.pry
      expect(Multidapter::Protocols::AmqpNode.call(amqp_uri, options)).to be_a(Bunny::Session)
    end

    it "should connect to RabbitMQ running on local system" do
      expect(Multidapter::Protocols::AmqpNode.call(amqp_uri, options).connect).to be_truthy
    end
  end


end