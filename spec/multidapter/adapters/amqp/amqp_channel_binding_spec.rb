# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Adapters::Amqp::AmqpChannelBinding do

  describe "exchange binding" do

    let(:is)              { :routing_key }
    let(:binding_version) { '0.2.0' }
    let(:name)            {  }
    let(:durable)         { true }
    let(:exclusive)       { true }
    let(:auto_delete)     { false }
    let(:vhost)           { '/' }

    let(:exchange)  { }
    let(:queue)  { }
  end



end
