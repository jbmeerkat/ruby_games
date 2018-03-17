# frozen_string_literal: true

module Pong
  # Stopwatch for game
  class Stopwatch
    attr_reader :clock, :last_clock_time

    def initialize(clock:)
      @clock = clock
    end

    def start
      self.last_clock_time = clock.milliseconds
    end

    def lap
      current_time = clock.milliseconds
      delta = current_time - last_clock_time
      self.last_clock_time = current_time

      delta
    end

    private

    attr_writer :last_clock_time
  end
end
