module Curate
  module Indexer
    # @api public
    #
    # Defines the interface for interacting with the InMemory layer. It is a reference
    # implementation that is used throughout tests.
    module InMemoryAdapter
      # @api public
      # @param pid [String]
      # @return Curate::Indexer::Document::PreservationDocument
      def self.find_preservation_document_by(pid)
        Preservation.find(pid)
      end

      # @api public
      # @param pid [String]
      # @return Curate::Indexer::Documents::IndexDocument
      def self.find_index_document_by(pid)
        Index.find(pid)
      end

      # @api public
      # @yield Curate::Indexer::Document::PreservationDocument
      def self.each_preservation_document
        Preservation.find_each { |document| yield(document) }
      end

      # @api public
      # @param pid [String]
      # @yield Curate::Indexer::Documents::IndexDocument
      def self.each_child_document_of(pid, &block)
        Index.each_child_document_of(pid, &block)
      end

      # @api private
      # This is not something that I envision using in the production environment;
      # It is hear to keep the Preservation system isolated and accessible only through interfaces.
      # @return Curate::Indexer::Documents::PreservationDocument
      def self.write_document_attributes_to_preservation_layer(attributes = {})
        Preservation.write_document(attributes)
      end

      # @api private
      # @return Curate::Indexer::Documents::IndexDocument
      def self.write_document_attributes_to_index_layer(attributes = {})
        Index.write_document(attributes)
      end
    end
  end
end