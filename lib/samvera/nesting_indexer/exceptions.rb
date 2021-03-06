module Samvera
  module NestingIndexer
    module Exceptions
      class RuntimeError < ::RuntimeError
      end

      # There is some kind configuration error.
      class ConfigurationError < RuntimeError
      end

      # Danger, the SolrKey may not be configured correctly.
      class SolrKeyConfigurationError < ConfigurationError
        attr_reader :name, :config
        def initialize(name:, config:)
          @name = name
          @config = config
          super "Expected #{name.inspect} to be set in Config #{config.inspect}"
        end
      end

      # Raised when we have a misconfigured adapter
      class AdapterConfigurationError < ConfigurationError
        attr_reader :expected_methods
        def initialize(object, expected_methods)
          @expected_methods = expected_methods
          super "Expected #{object.inspect} to implement #{expected_methods.inspect} methods"
        end
      end

      # Raised when we may have detected a cycle within the graph
      class CycleDetectionError < RuntimeError
        attr_reader :id
        def initialize(id)
          @id = id
          super "Possible graph cycle discovered related to PID=#{id}."
        end
      end
      # A wrapper exception that includes the original exception and the id
      class ReindexingError < RuntimeError
        attr_reader :id, :original_exception
        def initialize(id, original_exception)
          @id = id
          @original_exception = original_exception
          super "Error PID=#{id} - #{original_exception}"
        end
      end
    end
  end
end
