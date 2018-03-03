# frozen_string_literal: true

require 'securerandom'

module ECS
  # Entities factory
  class Entity
    def self.create
      SecureRandom.uuid
    end
  end
end
