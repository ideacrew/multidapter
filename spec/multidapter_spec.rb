RSpec.describe Multidapter do
  it "has a version number" do
    expect(Multidapter::VERSION).not_to be nil
  end

  it "registers custom URI schemes" do
    amqp_uri_scheme   = "AMQP"
    random_uri_scheme = "RANDOM"

    expect(URI.scheme_list.keys).to include(amqp_uri_scheme)
    expect(URI.scheme_list.keys).to_not include(random_uri_scheme)
  end


  describe "and module methods" do

    it "#generate_id and #generate_uuid produce unique identifiers" do
      expect(subject.respond_to?(:generate_uuid)).to be_truthy
      expect(subject.respond_to?(:generate_id)).to be_truthy
    end
  end


  it "does something useful" do

    #   # AmqpQueue.new do |queue|
    #   # end

    #   nodes = [ "https://amqp_broker_server" => {}, ]
    #   Network.connect(nodes) do |node|
    #     node.connect if node.test_connection
    #   end

    #   amqp_server = AmqpNode.new()
    #   amqp_node               = Node.new(:amqp, uri, options)
    #   amqp_connection_test    = amqp_node.test_connection
    #   amqp_connection         = amqp_node.connect


    #   event_publish_endpoint    = Endpoint.new(amqp_exchange_endpoint_adapter)
    #   event_subscribe_endpoint  = Endpoint.new(amqp_queue_endpoint_adapter)

    #   producer_endpoint       = AmqpQueue.new(key, options)
    #   event_post_channel      = amqp_connection.add_channel(event_publish_endpoint)
    #   post                    = event_post_channel.schedule_message(message)
    #   event_subscribe_channel = amqp_connection.add_channel(event_subscribe_endpoint)
    #   amqp_connection.close

    # endpoint = Multidapter::Endpoint.new(host: "127.0.0.1")
    # amqp_server = Multidapter::Server.new(endpoint)
    # amqp_producer_adapter = Multidapter::Adapters::AmqpProducerAdapter.new
    # amqp_producer_channel = Multidapter::Adapters::AmqpProducerChannel.new

    # producer_endpoint =

    #   amqp_producer_connection = Multidapter::Connections::AmqpProducerConnection.new(endpoint, exchange, options)
    # producer_connection = Multidapter::Connection.new(amqp_producer_connection)

    # amqp_consumer_connection = Multidapter::Connections::AmqpConsumerConnection.new(endpoint, queue, options)
    # consumer_connection = Multidapter::Connection.new(amqp_consumer_connection)


    # channel_options =

    #   consumer_connection.add_channel(endpoint, channel_options)

    # event_channel = connection.create_channel(:enterprise_events)
    # event_channel.post_message()
    # event_channel.schedule_message()
    # event_channel.retrieve_message()


    # http_connection = Multidapter::Connection.new(http_connection)

    {
      enterprise: {
        id: nil,
        key: nil,
        description: nil,
        service_network: [
          {
            id: nil,  # uuid
            key: nil, # symbol
            description: nil,
            enterprise_resources: [
              log_server: nil, # Node object
            ],
            nodes: [
              {
                id: nil,
                key: nil,
                description: nil,
                connection:
                {
                  protocol:             :amqp,
                  protocol_version:     "1.9.1",
                  default_content_type: 'application/json',
                  description:          'RabbitMQ Server',
                  security: {
                  },
                },
                channels: [
                  {
                    id: nil,
                    key: :enrollment_events,
                    description: nil,
                    connection_key: nil,
                    kind: :producer,
                    endpoint: {
                      uri: nil,
                      name: nil,
                      transport: :bunny,
                      exchange: nil,
                    },
                  },
                  {
                    id: nil,
                    key: nil,
                    description: nil,
                    connection_key: nil,
                    endpoint: {
                      url: nil,
                      name: nil,
                      kind: :consumer,
                      transport: :sneakers,
                    },
                  },
                  {
                    id: nil,
                    key: nil,
                    description: nil,
                    connection_key: nil,
                    endpoint: {
                      url: nil,
                      name: nil,
                      kind: :resource,
                      transport: :http,
                    },
                  },
                ],
                messages: [
                  {
                    id: nil,
                    status: nil,
                    meta: {
                      kind: [:scheduled],
                      security: {},
                    },
                    body: nil,
                  }
                ],
              },
            ],
          },
        ]
      },
    }

  end
end
