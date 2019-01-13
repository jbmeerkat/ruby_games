# frozen_string_literal: true

module Pong
  # All pong systems
  module Systems
  end
end

require_relative 'systems/movement'
require_relative 'systems/render_rectangle'
require_relative 'systems/render_net'
require_relative 'systems/left_racket_control'
require_relative 'systems/right_racket_control'
require_relative 'systems/ball'
require_relative 'systems/scoring'
require_relative 'systems/render_score'
