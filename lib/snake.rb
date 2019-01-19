# frozen_string_literal: true

require_relative 'snake/types'
require_relative 'snake/config'
require_relative 'snake/game'

# Snake game entry point
#
# @example
#   Snake.start(
#     Snake::Config[
#       logger: Logger.new(STDOUT),
#       window_width: 1024,
#       window_height: 768,
#       window_caption: 'Snake'
#     ]
#   )
module Snake
  module_function

  def start(config)
    game = Game.new(config)
    game.start
  end
end
