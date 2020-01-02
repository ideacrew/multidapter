# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Node do

  let(:amqp_uri)    { "amqp://localhost" }
  let(:options)     { {} }

  context "with default options" do
    it "should connect to RabbitMQ running on local system" do
      expect(Multidapter::Node.call(amqp_uri, options)).to be_nil
    end
  end

end
