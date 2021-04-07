# rubocop:disable all

# frozen_string_literal: true

require 'dry/transformer/all'
require "dry/inflector"
require 'json'

Inflector = Dry::Inflector.new

module Transform
  # collection of maps
  class MapSerializer

    attr_reader :source_ns, :output_ns, :mappings, :transform_action

    def initialize(source_namespace, output_namespace = nil, transform_action = nil)
      @source_ns = source_namespace.is_a?(Array) ? source_namespace.flatten : source_namespace.split('.')
      @output_ns = output_namespace.is_a?(Array) ? output_namespace.flatten : output_namespace.to_s.split('.')
      @transform_action = transform_action
      @mappings = {}
      construct_namespace_map
    end

    # namespace "lastUpdateMetadata", "lastUpdateData" do
    #   map
    # end

    # namespace "lastUpdateMetadata", "lastUpdateData" do
    #   namespace "application", 'consumer' do
    #     map
    #   end
    # end

    # namespace "lastUpdateMetadata.application", "lastUpdateData.consumer" do
    #   map
    # end

    def construct_namespace_map
      return if transform_action == :rewrap_keys
      return unless source_ns.length == output_ns.length

      source_ns.each_with_index do |namespace, index|
        container_key = source_ns[0..index].join('.')
        next if @mappings.key?(container_key)
        @mappings[container_key] = if index == 0
          Transform::Map.new(namespace, output_ns[index], :rename_keys)
        else
          Transform::Map.new(source_ns[0..index].join('.'), output_ns[0..index].join('.'), :rename_nested_keys)
        end
      end
    end

    def map(source_key = nil, output_key = nil)
      mapping = Transform::Map.new(
        (source_ns + [source_key]).join('.'),
        (output_ns + [output_key.to_s]).join('.'),
        transform_action || :rename_nested_keys
      )
      @mappings[mapping.source_key] = mapping
    end

    def rewrap(output_namespace = nil, &block)
      map = self.class.new(
        source_ns,
        output_ns + output_namespace.to_s.split('.'),
        :rewrap_keys
      )
      map.instance_exec(&block)

      @mappings.merge!(map.mappings)
    end

    def namespace(source_namespace, output_namespace = nil, &block)
      # @mappings << Transform::Map.new(source_namespace, output_namespace, :rename_keys) if output_namespace.present?
      map = self.class.new(
        source_ns + source_namespace.split('.'),
        output_ns + (output_namespace).to_s.split('.')
      )
      map.instance_exec(&block)

      @mappings.merge!(map.mappings)
    end
  end

  module Transformer
    extend Dry::Transformer::Registry
    import Dry::Transformer::HashTransformations
    import Dry::Transformer::ArrayTransformations
    import ::AcaEntities::Operations::HashFunctions

    import :camelize, from: Inflector, as: :camel_case
    import :underscore, from: Inflector, as: :underscore

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def map(source_key = nil, output_key = nil, *actions)
        mapping = Transform::Map.new(source_key, output_key, actions.flatten)
        # key = (mapping.namespace+[mapping.source_key]).map(&:to_s).join('.')
        mapping_container.register(mapping.source_key, mapping)
      end

      def namespace(source_namespace, output_namespace = nil, &block)
        map = MapSerializer.new(source_namespace, output_namespace)
        map.instance_exec(&block)
        map.mappings.each do |key, map|
          # key = (mapping.namespace+[mapping.source_key]).map(&:to_s).join('.')
          mapping_container.register(map.source_key, map) unless mapping_container.key?(map.source_key)
        end
      end

      def mapping_container
        @_maps_ ||= Dry::Container.new
      end
    end
  end

  class TransformFunctions
    extend Dry::Transformer::Registry

    import Dry::Transformer::HashTransformations
    import Dry::Transformer::ArrayTransformations
    import ::AcaEntities::Operations::HashFunctions
  end

  class Map
    attr_reader :source_key, :output_key, :key_transforms, :result, :transproc#, :namespace

    def initialize(source_key = nil, output_key = nil, *key_transforms, &block)
      @source_key = source_key
      @output_key = output_key
      @key_transforms = key_transforms
      # @namespace = []
      transform
    end

    def t(*args)
      ::Transform::TransformFunctions[*args]
    end

    def transform
      source_elements = source_key.split('.')
      output_elements = output_key.split('.')

      # key_transforms.push(:nest).uniq! if elements.size > 1

      transform_procs = key_transforms.inject([]) do |procs, action|
        procs << if action == :nest
        output_elements.size.times.collect do |i|
          offset = -1 * i
          "t(:nest, :#{output_elements[-2 + offset]}, [:#{output_elements[-1 + offset]}])" if output_elements[-2 + offset]
        end.compact
        elsif action == :rewrap_keys
          "t(:rewrap_keys, #{source_elements.map(&:to_sym)}, #{output_elements.map(&:to_sym)})"
        elsif action == :rename_nested_keys
          source = source_key.split('.').last
          "t(:#{action}, [#{source}: :#{output_elements.last}], #{source_elements[0..-2].map(&:to_sym)})"
        else
          "t(:#{action}, #{source_key}: :#{output_elements.last})"
        end
      end

      @transproc = eval(transform_procs.flatten.join('.>> '))
    end

    # def namespace=(value)
    #   @namespace = value
    # end

    def call(input)
      transproc.call(input)
    end

    # def process
    #   output_key || source_key
    #   # collect_namespace(a_hash, *namespace)
    #   # # @result  = send(:"#{action}_keys", a_hash.first, {from.to_sym => to.to_sym})
    #   # @result = t(:deep_rename_keys).call(a_hash, {from.to_sym => to.to_sym})
    #   #
    #   #
    #   # result = t(:deep_map_keys).call(a_hash) if action == :underscore
    #   # result = t(:"#{action}_keys").call(a_hash, from) if action == :deep_accept
    #   # result
    #   # # @result = t(:"#{action}_keys").call(a_hash,{from.to_sym => to.to_sym}) if action == :deep_rename
    # end

    # def t(*args)
    #   Transform::Transformer[*args]
    # end
  end
end

# rubocop:enable all