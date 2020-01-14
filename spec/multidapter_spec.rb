RSpec.describe Multidapter do
  it "has a version number" do
    expect(Multidapter::VERSION).not_to be nil
  end

  it "registers custom URI schemes" do
    amqp_uri_scheme   = "AMQP"
    random_uri_scheme = "RANDOM"

    expect(URI.scheme_list.keys.length).to be > 5
    # expect(URI.scheme_list.keys).to include(amqp_uri_scheme)
    expect(URI.scheme_list.keys).to_not include(random_uri_scheme)
  end


  describe "and module methods" do

    it "#generate_id and #generate_uuid produce unique identifiers" do
      expect(subject.respond_to?(:generate_uuid)).to be_truthy
      expect(subject.respond_to?(:generate_id)).to be_truthy
    end
  end


  it "does something useful" do

  end
end
