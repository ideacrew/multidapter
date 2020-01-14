# frozen_string_literal: true
require "spec_helper"

RSpec.describe URI::AMQP do

  let(:uri_scheme)          { "AMQP" }
  let(:custom_uri_string)   { "amqp://amqp.foo.com" }
  let(:default_port)        { 5672 }

  it "the custom scheme should be registered" do
    expect(URI.scheme_list.keys).to include uri_scheme
  end

  it "should construct a URL for the scheme" do
    expect(URI(custom_uri_string)).to be_a ::URI
  end

  it "registration should include the default port" do
    expect(URI(custom_uri_string).port).to eq default_port
  end

end
