# frozen_string_literal: true

# require 'dry/transformer/conditional'
require "dry/inflector"
require 'deep_merge'

module AcaEntities
  module Operations
    # This module provides services for hash transformations
    module HashFunctions
      module_function

      # Rename particular keys using namespace
      #
      # @param source_hash The input hash
      # @param mapping The key-rename mapping
      #
      # @example
      #   source_hash: {"a" => {"b" => { "c" => {"d" => "123"}}, {"d" => "456"}}, mapping: {"d" => "e"}, namespaces: [:a,:b,:c]
      #   # =>   {"a" => {"b" => { "c" => {"e" => "123"}}, {"d" => "456"}}
      #
      # @return [Hash]
      def rename_nested_keys(source_hash, mapping, namespaces = [])
        puts "------>>>> #{namespaces} ---- #{source_hash}"
        source_hash.to_h.tap do |hash|
          final_pair = hash.dig(*namespaces)
          mapping.first.each {|k, v| final_pair[v] = final_pair.delete(k) if final_pair.key?(k)}
        end
      end

      def rewrap_keys(source_hash, source_namespaces, destination_namespaces = [])
        puts "------>>>> unwrap #{source_hash} -- #{source_namespaces} ---- #{destination_namespaces}"
        binding.pry
        source_hash.to_h.tap do |source_data|
          # final_pair = hash.dig(*namespaces)
          # mapping.first.each {|k, v| final_pair[v] = final_pair.delete(k) if final_pair.key?(k)}
          data_hash = source_data.dig(*source_namespaces[0..-2])

          element = destination_namespaces.pop
          # destination_namespaces.pop
          output = initialize_or_assign({}, destination_namespaces.dup, Hash[element, data_hash[source_namespaces.last]])
         
          puts "-----output --- #{output.inspect}"

          source_data[destination_namespaces[0]] = output[destination_namespaces[0]]
          source_data.delete(source_namespaces[0])
        end
      end

      def initialize_or_assign(local_record, values = [], data)
        if current_namespace = values.shift
          local_record[current_namespace] ||= {} 

          if values.empty?
            local_record[current_namespace].deep_merge!(data)
          else
            local_record[current_namespace] = initialize_or_assign(local_record[current_namespace], values, data)
          end
        else
          local_record.deep_merge!(data)
        end

        local_record
      end


      # Rename all keys upto nested hash
      #
      # @param source_hash The input hash
      # @param mapped_keys The key-rename mapping
      #
      # @example
      #   source_hash: {"a" => {"b" => { "c" => {"d" => "123"}}, {"d" => "456"}}, mapping: {"d" => "e"}
      #   # =>  {"a" => {"b" => { "c" => {"e" => "123"}}, {"e" => "456"}}
      #
      # @return [Hash]
      def deep_rename_keys(source_hash, mapped_keys)
        source_hash.each_with_object({}) do |(k, v), result|
          mapped_key = mapped_keys[k] || k
          result[mapped_key] = case v
                               when ::Hash
                                 deep_rename_keys(v, mapped_keys)
                               when ::Array
                                 v.map do |item|
                                   item.is_a?(Hash) ? deep_rename_keys(item, mapped_keys) : item
                                 end
                               else
                                 v
                               end
        end
      end

      def deep_accept_keys(source_hash, permitted_keys)
        source_hash.each_with_object({}) do |(key, value), output|
          next unless permitted_keys.include? key
          output[key] = case value
                        when ::Hash
                          deep_accept_keys(value, permitted_keys)
                        when ::Array
                          value.map do |item|
                            item.is_a?(Hash) ? deep_accept_keys(item, permitted_keys) : item
                          end
                        else
                          value
                        end
        end
      end

      def deep_map_keys(hash)
        inflector = Dry::Inflector.new
        hash.each_with_object({}) do |(key, value), output|
          output[inflector.underscore(key).to_sym] =
            case value
            when Hash
              deep_map_keys(value)
            when Array
              value.map do |item|
                item.is_a?(Hash) ? deep_map_keys(item) : item
              end
            else
              value
            end
        end
      end

      # TODO
      def collect_namespace(source_hash, *keys)
        keys = keys.dup
        next_key = keys.shift

        return [] unless source_hash.key? next_key

        next_val = source_hash[next_key]

        return [next_val] if keys.empty?

        case next_val
        when Hash
          next_val.collect_namespace(*keys)
        when Array
          next_val.each_with_object([]) do |v, result|
            inner = v.collect_namespace(*keys)
            result.concat inner
          end
        else
          []
        end
      end
    end
  end
end