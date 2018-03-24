# frozen_string_literal: true

module Pong
  # All pong systems
  module Systems
  end
end

require_relative 'systems/movement'
require_relative 'systems/render_rectangle'
require_relative 'systems/left_platform_control'
require_relative 'systems/right_platform_control'
