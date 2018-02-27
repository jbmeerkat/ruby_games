# frozen_string_literal: true

require 'securerandom'

module ECS
  # Registry of all entities
  class EntityRegistry
    # component registers looks like this
    #   {
    #     ComponentClass: {
    #       'entity_id': [component_instance1, component_instance2]
    #     }
    #   }
    def initialize
      @entities_tags = {}
      @tags_entities = {}
      @component_registers = Hash.new { |hash, key| hash[key] = {} }
    end

    def create_entity(tag: nil)
      entity = SecureRandom.uuid
      entities_tags[entity] = tag
      tags_entities[tag] = entity if tag

      entity
    end

    def add_component(entity, component)
      registry = component_registers[component.class]

      if registry.key?(entity) && !registry[entity].include?(component)
        registry[entity] << component
      else
        registry[entity] = [component]
      end

      entity
    end

    def entity_components(entity)
      component_registers.values.each_with_object([]) do |register, memo|
        components = register[entity]
        memo.concat(components) if components
      end
    end

    def entities_with_component(component)
      component_registers[component.class].keys
    end

    private

    attr_accessor :entities_tags, :tags_entities, :component_registers
  end
end
