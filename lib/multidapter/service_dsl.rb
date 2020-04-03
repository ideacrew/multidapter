# frozen_string_literal: true

amqp_service_info = Info.new(title: "AMQP Broker",
                             version: "0.9.1",
                             description: "RabbitMQ server instance",
                             )

amqp_primary_host = Server.new(protocol: :amqp,
                               url: "amqp://localhost",
                               description: "Primary AMQP host",
                               security_scheme: { type: :user_password },
                               variables: [
                                 port:           { default: 15672 },
                                 vhost:          { default: '/' },
                                 auth_mechanism: { default: 'PLAIN' },
                                 user:           { default: 'guest' },
                                 password:       { default: 'guest' },
                                 ssl:            { default: false },
                                 heartbeat:      { default: :server },
                               ],
                               )

amqp_dr_host  = Server.new(protocol: :amqp,
                           url: "amqp://localhost",
                           description: "Primary AMQP host",
                           security_scheme: { type: :user_password },
                           variables: [
                             port:           { default: 15672 },
                             vhost:          { default: '/' },
                             auth_mechanism: { default: 'PLAIN' },
                             user:           { default: 'guest' },
                             password:       { default: 'guest' },
                             ssl:            { default: false },
                             heartbeat:      { default: :server },
                           ],
                           )

logger_publisher  = Channel.new(channel_id: :logger_messages,
                                channel_item: {
                                  publish: {
                                    operation_id: :log_message,
                                    summary: 'Post a message to the logger'
                                  },
                                  bindings: {
                                    amqp: {
                                      is: :queue,
                                      queue: { exclusive: true }
                                    }
                                  },
                                }
                                )

smtp_publisher  = Channel.new(channel_id: :email_messages,
                              channel_item: {
                                publish: {
                                  operation_id: :send_email,
                                  summary: 'Post a message to the SMTP server'
                                },
                                bindings: {
                                  amqp: {
                                    is: :queue,
                                    queue: { exclusive: true }
                                  }
                                },
                              }
                              )

priority_smtp_publisher = Channel.new(channel_id: :priority_email_messages,
                                      channel_item: {
                                        publish: {
                                          operation_id: :send_priority_email,
                                          summary: 'Post a high priority message to the SMTP server'
                                        },
                                        bindings: {
                                          amqp: {
                                            is: :queue,
                                            queue: { exclusive: true }
                                          }
                                        },
                                      }
                                      )

amqp_service = Service.new(id: :amqp_service,
                           asyncapi: "2.0",
                           info: amqp_service_info,
                           servers:  [amqp_primary_server],
                           channels: [logger_publisher, smtp_publisher, priority_smtp_publisher],
                           )


aws_s3_service = {}


enroll_service.configuration do |config|
  config.id   = :shop_market_event_publisher
  config.info =  ""
end

enroll_service = Service.create(
  asyncapi: "2.0",
  id:       :shop_market,
  info:     info,
  servers:  servers,
)


# Multidapter::Operations::Create.call(service_params)


module Multidapter
  class ServiceDsl < Service





  end
end
