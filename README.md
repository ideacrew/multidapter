# Multidapter

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/multidapter`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multidapter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multidapter

## Usage

### Overview

#### AMQP Example
1. Create node for application
1. connect to a server
1. connect to server and access api
1. post message to an Exchange
1. bind to a queue and collect a message
1. bind to a queue and ack a message


### Node

Node is a singleton

```
Node = Multidapter::Node.new(id)
Node.configure() do |conf|
  conf.id       = "<application_name>"
  conf.asyncapi = "2.0"

  conf.title        = "<application_name>"
  conf.version      = "1.0"
  conf.description  = ""


  conf.servers  = [
    LogServer   = "",
    SmtpServer  = "",
  ]

  conf.channels = []

  log_channel   = connection_adapter.create_channel(log_producer_channel)
  smtp_channel  = connection_adapter.create_channel(smtp_producer_channel)
end
```

### ConnectionAdapter

```
my_uri = URI("amqp://guest:guest@vm188.dev.megacorp.com/profitd.qa")

amqp_conn     = Multidapter::Server.connect
log_channel   = amqp_conn.create_channel()
log_messageq  = log_channel.build_message()
result        = log_message.post()

amqp_server_binding_options = {}
amqp_server_url = URI("amqp://guest:guest@vm188.dev.megacorp.com/")
amqp_server = Multidapter::Server.add(amqp_server_url, amqp_server_binding_options)
amqp_conn = amqp_server.connect(amqp_server_url, amqp_server_binding_options)

result = amqp_conn.test_connection

...

amqp_conn.close

# ServerConnection supports blocks

amqp_server_binding_options = {}
amqp_server = Multidapter::Server.add(amqp_server_url, amqp_server_binding_options)
Multidapter::Server.connect(amqp_server_url, amqp_server_binding_options) do |amqp_conn|
  event_publish_channel     = amqp_conn.create_channel(event_producer_channel_def)
  event_subscribe_channel   = amqp_conn.create_channel(event_consumer_channel_def)

  service_client_channel    = amqp_conn.create_channel(consumer_listener_channel_def)
  service_reply_to_channel  = amqp_conn.create_channel(producer_reply_to_channel_def)

  enrollment_event_message.create() do |message|
    message.content_type  = "application/json"
    message.payload       = { text: "Hello world" }
  end

  enrollment_event_message.send(event_publish_channel)            # Message is PORO that includes Multidapter::Message
  enrollment_event_message.send_scheduled(event_publish_channel)  # class Includes Multidapter::Message
end


event_publish_channel.configure do |conf|

end
```
      producer_endpoint       = AmqpQueue.new(key, options)
      event_post_channel      = amqp_connection.add_channel(event_publish_endpoint)
      post                    = event_post_channel.schedule_message(message)
      event_subscribe_channel = amqp_connection.add_channel(event_subscribe_endpoint)
      amqp_connection.close

    endpoint = Multidapter::Endpoint.new(host: "127.0.0.1")
    amqp_server = Multidapter::Server.new(endpoint)
    amqp_producer_adapter = Multidapter::Adapters::AmqpProducerAdapter.new
    amqp_producer_channel = Multidapter::Adapters::AmqpProducerChannel.new

    producer_endpoint =

      amqp_producer_connection = Multidapter::Connections::AmqpProducerConnection.new(endpoint, exchange, options)
    producer_connection = Multidapter::Connection.new(amqp_producer_connection)

    amqp_consumer_connection = Multidapter::Connections::AmqpConsumerConnection.new(endpoint, queue, options)
    consumer_connection = Multidapter::Connection.new(amqp_consumer_connection)


    channel_options =

      consumer_connection.add_channel(endpoint, channel_options)

    event_channel = connection.create_channel(:enterprise_events)
    event_channel.post_message()
    event_channel.schedule_message()
    event_channel.retrieve_message()


    http_connection = Multidapter::Connection.new(http_connection)

    {
      Amqp: {
        servers:        [],
        channels:       [],
        components:     [],
        tags:           [],
        external_docs:  [],
      },
      Http: {},
    }


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
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/multidapter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Multidapter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/multidapter/blob/master/CODE_OF_CONDUCT.md).
