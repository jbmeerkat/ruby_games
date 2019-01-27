# frozen_string_literal: true

# Stopwatch for game
class Stopwatch
  attr_reader :clock, :last_clock_time

  def initialize(clock:)
    @clock = clock
    @paused = false
  end

  def start
    @paused = false

    self.last_clock_time = clock.milliseconds
  end

  def lap
    return 0 if paused?

    current_time = clock.milliseconds
    delta = current_time - last_clock_time
    self.last_clock_time = current_time

    delta
  end

  def pause
    @paused = true
  end

  def paused?
    @paused
  end

  private

  attr_writer :last_clock_time
end
