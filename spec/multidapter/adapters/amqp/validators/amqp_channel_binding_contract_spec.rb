# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Adapters::Amqp::Validators::AmqpChannelBindingContract do

  let(:is)                    { :routing_key }
  let(:binding_version)       { '0.2.0' }

  let(:exchange)              { {
                                  name: 'exchange-name',
                                  type: :topic,
                                  durable: true,
                                  auto_delete: false,
                                  vhost: '/',
                                }
                                }

  let(:queue)                 { {
                                  name: 'queue-name',
                                  exclusive: true,
                                  durable: true,
                                  auto_delete: false,
                                  vhost: '/',
                                }
                                }

  let(:all_params)              { {
                                    is: is,
                                    binding_version:  binding_version,
                                    exchange:         exchange,
                                    queue:            queue,
                                  }
                                  }

  context "when parameters include an invalid AMQP Channel Binding type" do
    let(:invalid_is)        { :invalid_type }
    let(:invalid_params)    { { is: invalid_is } }
    let(:error_hash)        { {:is=>["must be one of: routing_key, queue"]} }

    it { expect(subject.call(invalid_params).errors.to_h).to eq error_hash }
  end

  context "Given an Exchange-only binding" do
    context "with invalid parameters" do

      context "an invalid Exchange type" do
        let(:invalid_exchange)        { exchange.update(type: :invalid_type) }
        let(:invalid_exchange_params) { {
                                          is: is,
                                          binding_version:  binding_version,
                                          exchange:         invalid_exchange,
                                        }
                                        }
        let(:error_hash)            { {:exchange=>{:type=>["must be one of: topic, fanout, default, direct, headers"]}} }

        it { expect(subject.call(invalid_exchange_params).errors.to_h).to eq error_hash }

      end
    end

    context "with valid parameters" do
      let(:exchange_params)         { { is: is, binding_version:  binding_version, exchange: exchange } }

      it "contract validation should pass" do
        # binding.pry
        expect(subject.call(exchange_params).to_h).to eq exchange_params
      end

      it "should create new Channel Binding instance" do
        amqp_channel_binding = Multidapter::Adapters::Amqp::AmqpChannelBinding.new(exchange_params)
        expect(amqp_channel_binding.to_h).to eq exchange_params
      end
    end
  end

  context "Given a valid Exchange and Queue binding" do

    it "contract validation should pass" do
      expect(subject.call(all_params).to_h).to eq all_params
    end

    it "should create new Channel Binding instance" do
      amqp_channel_binding = Multidapter::Adapters::Amqp::AmqpChannelBinding.new(all_params)
      expect(amqp_channel_binding.to_h).to eq all_params
    end
  end

end
