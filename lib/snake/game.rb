# frozen_string_literal: true

require_relative '../window'
require_relative 'game_scene'

module Snake
  # Game state representation
  class Game
    extend Dry::Initializer
    extend Forwardable

    param :config, Types::Any.constrained(type: Snake::Config)

    def_delegators :config, :window
    def_delegators :config, :logger

    def start
      scene = GameScene.new(game: self)
      window.scene = scene

      window.show
    end
  end
end
