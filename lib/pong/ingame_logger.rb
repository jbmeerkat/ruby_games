# frozen_string_literal: true

module Pong
  # Logger for onscreen rendering
  class IngameLogger < Logger
    # Message queue log device
    class Device
      LOG_LENGTH = 50

      attr_reader :messages

      def initialize(*args)
        @messages = []

        super
      end

      def write(message)
        @messages << message
        truncate_log
      end

      def close
        # noop
      end

      private

      def truncate_log
        @messages = @messages.last(LOG_LENGTH)
      end
    end

    def initialize(level: DEBUG)
      super(Device.new, level: level, progname: 'pong')
    end

    def messages
      @logdev.dev.messages
    end
  end
end
