# frozen_string_literal: true

module Snake
  class GameScene
    class Foo < ECS::System
      run_on :draw

      def run
        @runned ||= 0
        @runned += 1

        return if @runned % 2 == 0

        @width = 100 unless @width
        @height = 100 unless @height

        if time_delta > 0
          @width = rand(100..400)
          @height = rand(100..400)
        end

        Gosu.draw_rect(world.width / 2 - @width / 2, world.height / 2 - @height / 2, @width, @height, Gosu::Color::WHITE)
      end
    end

    attr_reader :game, :world, :stopwatch

    def initialize(game:)
      @paused = false
      @game = game
      @world = ECS::World.new(width: game.window.width, height: game.window.height)
      @stopwatch = Stopwatch.new(clock: Gosu)
    end

    def setup
      world.add_system(Foo.new)
      stopwatch.start
    end

    def pause
      @paused = true
      stopwatch.pause

      game.logger.info('Paused')
    end

    def resume
      @paused = false
      stopwatch.start

      game.logger.info('Resumed')
    end

    def paused?
      @paused
    end

    def draw
      world.draw
    end

    def update
      world.update(time_delta: stopwatch.lap)
    end

    def button_pressed(id)
      game.logger.info("Pressed #{id}")

      if Gosu.button_down?(Gosu::KB_ESCAPE)
        paused? ? resume : pause
      end
    end
  end
end
