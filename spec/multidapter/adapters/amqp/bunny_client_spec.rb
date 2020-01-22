require 'spec_helper'

RSpec.describe Multidapter::Adapters::Amqp::BunnyClient do

  it "should be updated for inclusion in Multidapter gem"

  return 


  let(:forwarding_queue_name) { "acapi.queue.events.local" }
  let(:forwarding_exchange_name ) { "acapi.exchange.events.local" }


  describe "which publishes messages" do
    let(:session) { instance_double("Bunny::Session") }
    let(:channel) { instance_double("Bunny::Channel") }
    let(:queue) { instance_double("Bunny::Queue") }
    let(:exchange) { instance_double("Bunny::Exchange") }
    let(:app_id) { "my app" }
    subject { ::Acapi::LocalAmqpPublisher.new(app_id) }

    let(:event_name) { "acapi.individual.created" }
    let(:started_at) { double(:to_i => 12345) }
    let(:finished_at) { double(:to_i => 12345) }
    let(:message_id) { double }
    let(:other_property_1) { double }
    let(:other_property_2) { double }
    let(:correlation_id) { double }
    let(:reply_to) { double }

    let(:payload) { { 
      :other_property_1 => other_property_1,
      :other_property_2 => other_property_2,
    } }

    before :each do
      allow(Bunny).to receive(:new).and_return(session)
      allow(session).to receive(:start)
      allow(session).to receive(:create_channel).and_return(channel)
      allow(channel).to receive(:queue).with(forwarding_queue_name, {:durable => true}).and_return(queue)
      allow(channel).to receive(:fanout).with(forwarding_exchange_name, {:durable => true}).and_return(exchange)
      allow(queue).to receive(:bind).with(exchange, {})
    end

    it "should establish a connection to the local broker" do
      allow(exchange).to receive(:publish)
      expect(Bunny).to receive(:new).and_return(session)
      expect(session).to receive(:start)
      expect(session).to receive(:create_channel).and_return(channel)
      subject.log(event_name, started_at, finished_at, message_id, {:app_id => "whatever"})
    end

    it "should establish a persistent queue on the local broker" do
      allow(exchange).to receive(:publish)
      expect(channel).to receive(:queue).with(forwarding_queue_name, {:durable => true}).and_return(queue)
      subject.log(event_name, started_at, finished_at, message_id, {:app_id => "whatever"})
    end

    it "publishes with a routing key the same as the event name, just stripped of 'acapi.'" do
      expect(exchange).to receive(:publish) do |body, opts|
        expect(body).to eql ""
        expect(opts[:routing_key]).to eq "individual.created"
      end
      subject.log(event_name, started_at, finished_at, message_id, payload)
    end

    it "creates the submitted_timestamp key from the finished_at property of the event" do
      expect(exchange).to receive(:publish) do |body, opts|
        expect(body).to eql ""
        expect(opts[:headers][:submitted_timestamp]).to eq finished_at
      end
      subject.log(event_name, started_at, finished_at, message_id, payload)
    end
    
    it "uses the :body property of the event to populate the body of the message" do
      message_body_content = "a message body"
      message_body = double(:to_s => message_body_content)
      message_with_body = payload.merge(:body => message_body)
      expect(exchange).to receive(:publish) do |body, opts|
        expect(body).to eql message_body_content
      end
      subject.log(event_name, started_at, finished_at, message_id, message_with_body)
    end

    it "supports reply_to as a property" do
      expect(exchange).to receive(:publish) do |body, opts|
        expect(body).to eql ""
        expect(opts[:reply_to]).to eq reply_to 
      end
      message_with_reply_to = payload.merge(:reply_to => reply_to)
      subject.log(event_name, started_at, finished_at, message_id, message_with_reply_to)
    end

    it "supports correlation id as a property" do
      expect(exchange).to receive(:publish) do |body, opts|
        expect(body).to eql ""
        expect(opts[:correlation_id]).to eq correlation_id
      end
      message_with_correlation = payload.merge(:correlation_id => correlation_id)
      subject.log(event_name, started_at, finished_at, message_id, message_with_correlation)
    end

    it "uses all other event properties as headers" do
      expect(exchange).to receive(:publish) do |body, opts|
        expect(body).to eql ""
        expect(opts[:headers][:other_property_1]).to eq other_property_1
        expect(opts[:headers][:other_property_2]).to eq other_property_2
      end
      subject.log(event_name, started_at, finished_at, message_id, payload)
    end

    it "should use the submitted_timestamp property for the start/end times if it exists" do
      given_timestamp = "frank"
      expect(exchange).to receive(:publish) do |body, opts|
        expect(body).to eql ""
        expect(opts[:headers][:submitted_timestamp]).to eq given_timestamp 
      end
      subject.log(event_name, started_at, finished_at, message_id, payload.merge({:submitted_timestamp => given_timestamp}))
    end
  end

  describe "that can support unicorn" do
    let(:session) { instance_double("Bunny::Session") }
    let(:channel) { instance_double("Bunny::Channel") }
    let(:queue) { instance_double("Bunny::Queue") }
    let(:exchange) { instance_double("Bunny::Exchange") }
    subject { ::Acapi::LocalAmqpPublisher.new("some app id") }

    it "supports reconnection for after_fork" do
      #publish to force the connection
      allow(exchange).to receive(:publish)
      expect(session).to receive(:close)
      expect(Bunny).to receive(:new).and_return(session)
      expect(session).to receive(:start)
      expect(session).to receive(:create_channel).and_return(channel)
      expect(channel).to receive(:queue).with(forwarding_queue_name, {:durable=> true}).and_return(queue)
      expect(channel).to receive(:fanout).with(forwarding_exchange_name, {:durable => true}).and_return(exchange)
      expect(queue).to receive(:bind).with(exchange, {})
      subject.log("", nil, nil, nil, {:app_id => "some app id"})
      subject.reconnect!
    end

  end
end
