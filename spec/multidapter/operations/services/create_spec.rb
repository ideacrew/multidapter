# frozen_string_literal: true

require "spec_helper"

RSpec.describe Multidapter::Operations::Services::Create do

  let(:asyncapi)      { "2.0" }
  let(:id)            { :application_key }

  let(:title)         { "Application Title" }
  let(:version)       { "0.1.0" }
  let(:info)          { { title: title, version: version } }

  let(:channel_id)    { :email_notices }
  let(:channels)      { [{channel_id: channel_id}] }


  describe '#call' do
    context "with missing params" do
      let(:required_params)   { { asyncapi: asyncapi, id: id, info: info, channels: channels } }

      it 'should fail to create an application instance' do
        expect(subject.call({asyncapi: asyncapi}).success?).to be_falsey
      end
    end

    context "with required params" do
      let(:required_params)   { { asyncapi: asyncapi, id: id, info: info, channels: channels } }

      it 'should successfully create an application instance' do
        result = subject.call(required_params)

        expect(result.success?).to be_truthy
        expect(result.value!).to be_a Multidapter::Service

        expect(result.value!.to_h[:asyncapi]).to eq asyncapi
        expect(result.value!.to_h[:id]).to eq id

        expect(result.value!.info).to be_a Multidapter::Info
        expect(result.value!.info.to_h[:title]).to eq title
        expect(result.value!.info.to_h[:version]).to eq version

        expect(result.value!.channels.first).to be_a Multidapter::Channel
        expect(result.value!.channels.first.to_h).to eq Hash(channel_id: channel_id)
      end
    end
  end
end
