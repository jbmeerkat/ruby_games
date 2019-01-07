# frozen_string_literal: true

module Pong
  module Systems
    class RenderNet < ECS::System
      watch_components :net, :position
      run_on :draw

      def process_entity(_entity, net, position)
        net.sections.times do |index|
          Gosu.draw_rect(
            position.x,
            index * net.section_length * 2,
            net.section_width,
            net.section_length,
            Gosu::Color::WHITE
          )
        end
      end
    end
  end
end
