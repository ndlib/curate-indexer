require 'spec_helper'
require 'samvera/nesting_indexer/railtie'

module Samvera
  module NestingIndexer
    RSpec.describe Railtie do
      context '.config' do
        let(:railtie) { described_class }
        let(:config) { railtie.config }
        context '.eager_load_namespaces' do
          subject { config.eager_load_namespaces }
          it { is_expected.to_not include(Samvera::NestingIndexer) }
        end
        context '.to_prepare_blocks' do
          subject { config.to_prepare_blocks }
          it { is_expected.to_not be_empty }
          it 'will configure the indexer when called' do
            expect(Samvera::NestingIndexer).to receive(:configure!)
            config.to_prepare_blocks.each(&:call)
          end
        end
      end
    end
  end
end
