require 'ruboty'
require 'mastodon'
require 'sanitize'

module Ruboty
  module Adapters
    class Mastodon < Base
      env :MASTODON_URL, 'Mastodon url'
      env :MASTODON_TOKEN, 'Mastodon access token'

      def run
        listen
      end

      def say(message)
        rest_client.create_status(
          "@#{message[:original][:from]} #{message[:body]}",
          in_reply_to_id: message[:original][:message].id,
          visibility: message[:original][:message].visibility,
        )
      end

      private

      def listen(retry_count: 0)
        Ruboty.logger.info("connecting to #{ENV['MASTODON_URL']} (retry_count: #{retry_count})")
        begin
          streaming_client.user do |payload|
            Ruboty.logger.debug(payload.inspect)
            if payload.is_a?(::Mastodon::Notification) && payload.status?
              message = payload.status
              Ruboty.logger.debug("#{message.account.acct} tooted #{::Sanitize.fragment(message.content).strip.inspect}")
              robot.receive(
                body: ::Sanitize.fragment(message.content).strip,
                from: message.account.acct,
                message: message
              )
            end
          end
          retry_count = 0
        rescue Errno::ECONNREFUSED, EOFError => e
          Ruboty.logger.error(e.message)
          sleep(2**retry_count)
          listen(retry_count: retry_count + 1)
        end
      end

      def streaming_client
        @streaming_client ||= ::Mastodon::Streaming::Client.new(
          base_url: ENV['MASTODON_STREAMING_URL'] || ENV['MASTODON_URL'],
          bearer_token: ENV['MASTODON_TOKEN']
        )
      end

      def rest_client
        @rest_client ||= ::Mastodon::REST::Client.new(
          base_url: ENV['MASTODON_URL'],
          bearer_token: ENV['MASTODON_TOKEN']
        )
      end

      def me
        @me ||= rest_client.verify_credentials.acct
      end
    end
  end
end
