# frozen_string_literal: true

module Pong
  module Systems
    # Shows current scores on the screen
    class RenderScore < ECS::System
      run_on :draw

      watch_components :score

      def process_entity(_entity, score)
        font = Gosu::Font.new(50, name: MenuWindow::FONT_PATH)

        left_score = score.left.to_s.rjust(2, '0')
        right_score = score.right.to_s.rjust(2, '0')

        draw_text(font, left_score, -100)
        draw_text(font, right_score, 40)
      end

      private

      def draw_text(font, text, x_displacement)
        font.draw_text(text, world.width / 2 + x_displacement, 20, 1, 1.0, 1.0,
          Gosu::Color::WHITE)
      end
    end
  end
end
