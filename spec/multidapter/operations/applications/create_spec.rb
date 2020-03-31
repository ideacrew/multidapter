# frozen_string_literal: true

require "spec_helper"

RSpec.describe Multidapter::Operations::Applications::Create do

  let(:asyncapi)      { "2.0" }
  let(:id)            { :adapter_id }

  let(:title)         { "Adapter Title" }
  let(:version)       { "0.1.0" }
  let(:info)          { { title: title, version: version } }

  let(:channel_id)    { "email_notices" }
  let(:channels)      { [{channel_id: channel_id}] }


  describe '#call' do
    context "with missing params" do
      let(:required_params)   { { asyncapi: asyncapi, info: info, channels: channels } }

      it 'should create an application instance' do
        expect(subject.call({asyncapi: asyncapi}).success?).to be_falsey
      end
    end

    context "with required params" do
      let(:required_params)   { { asyncapi: asyncapi, info: info, channels: channels } }

      it 'should create an application instance' do
        expect(subject.call(required_params).success?).to be_truthy
      end
    end
      end

end
