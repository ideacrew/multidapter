# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Endpoint do

  let(:uri_scheme)  { "uri" }
  let(:uri_min)     { URI::parse("#{uri_scheme}://") }

  context "When an address is initialized without parameters" do
    subject { described_class.new() }

    it "the URI scheme component should have a default value" do
      expect(subject.scheme).to eq uri_scheme
    end

    it "and the URI query component string should be empty string" do
      expect(subject.query).to eq ""
    end

    it "and the #to_uri method should return a URI with only a scheme" do
      expect(subject.to_uri).to eq uri_min
    end
  end

  context "When an address is initialized with minimum required parameters" do

    let(:host)    { "host_value" }
    let(:path)    { "path_value" }
    let(:uri)     { URI::parse("#{uri_scheme}://#{host}/#{path}")}

    it "to_uri method should return a valid URI" do
      expect(described_class.new(host: host, path: path).to_uri).to eq uri
    end
  end

  context "When an address is initialized with all URI components except query" do
    let(:host)      { "host_value" }
    let(:path)      { "path_value" }
    let(:userinfo)  { "userinfo_value" }
    let(:port)      { 9999 }
    let(:uri_max)   { URI::parse("#{uri_scheme}://#{userinfo}@#{host}:#{port}/#{path}")}

    it "to_uri method should return a valid URI" do
      expect(described_class.new(
                                    host: host,
                                    path: path,
                                    userinfo: userinfo,
                                    port: port,
                                  ).to_uri).to eq uri_max
    end
  end

end
