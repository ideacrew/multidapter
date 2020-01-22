# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Multidapter::Adapters::Amqp::AmqpBunnyAdapter do

  it "The Bunny library should be present" do
    expect(be_const_defined(::Bunny)).to be_truthy
  end

  describe "Given a valid server configuration" do
    let(:server_params)         { {url: '127.0.0.1', protocol: :amqp, } }
    let(:server_object_klass)   { Multidapter::AsyncApi::Operations::CreateServer }
    let(:server_object)         { server_object_klass.new.call(server_params).value! }

    let(:open_status)           { :open }
    let(:version)               { "2.14.3"  }
    let(:protocol_version)      { "0.9.1"  }

    it "should initialize a Server" do
      expect(server_object).to be_a Multidapter::AsyncApi::Server
    end

    subject { described_class.new(server_object) }

    it "should respond to #version and #protocol_version" do
      expect(subject.version).to eq version
      expect(subject.protocol_version).to eq protocol_version
    end

    it "should initialize an AmqpBunnyAdapter instance" do
      expect(subject.connection).to be_a Bunny::Session
    end

    it "the instance should reflect the Server bindings" do
      expect(subject.connection.host).to eq server_object.to_h[:url].to_s
    end

    it "the instanace should connect to a server host and provide status" do
      subject.connect
      expect(subject.active?).to be_truthy
      expect(subject.connection_status).to eq open_status
    end

    it "should close" do
      subject.connect
      expect(subject.active?).to be_truthy
      subject.close
      expect(subject.active?).to be_falsey
    end

    it "using class #call method should open connection in one step" do
      expect(described_class.call(server_object).active?).to be_truthy
    end

  end


  let(:server_def)  {
    {
      url:              '127.0.0.1',
      description:      'AMQP host',
      protocol:         :amqp,
      security: {
        type: :user_password,
        description: 'Default credentials for RabbitMQ'
      },
      variables: {
        port:           { default: 15672 },
        vhost:          { default: '/' },
        auth_mechanism: { default: 'PLAIN' },
        user:           { default: 'guest' },
        password:       { default: 'guest' },
        ssl:            { default: false },
        heartbeat:      { default: :server },
      },
    }

  }

  it "should test more complex params and mock connection scenarios"

end
