# encoding: utf-8
# copyright: 2017, Chef Software Inc.

require 'helper'

describe Inspec::Reporters::Base do
  let(:path) { File.expand_path(File.dirname(__FILE__)) }
  let(:report) { Inspec::Reporters::Base.new(JSON.parse(File.read(path + '/_data/run_data.json'), :symbolize_names=>true)) }

  describe '#output' do
    it 'append to output' do
      report.output ''
      report.output 'test'
      report.output ''
      assert = report.instance_variable_get(:@output)
      assert.must_equal "\ntest\n\n"
    end
  end

  describe '#all_unique_controls' do
    it 'return unique controls' do
      report.all_unique_controls.count.must_equal 4
    end

    it 'return unique controls cached' do
      instance_variable_get(:@unique_controls).must_be_nil
      report.all_unique_controls.count.must_equal 4
      assert = report.instance_variable_get(:@unique_controls)
      assert.count.must_equal 4
    end
  end

  describe '#profile_summary' do
    it 'correct profile summary' do
      expect = {"total"=>1, "failed"=>{"total"=>0, "critical"=>0, "major"=>0, "minor"=>0}, "skipped"=>0, "passed"=>1}
      report.profile_summary.must_equal expect
      assert = report.instance_variable_get(:@profile_summary)
      assert.count.must_equal 4
    end
  end

  describe '#tests_summary' do
    it 'correct tests summary' do
      expect = {"total"=>0, "failed"=>1, "skipped"=>0, "passed"=>3}
      report.tests_summary.must_equal expect
      assert = report.instance_variable_get(:@tests_summary)
      assert.count.must_equal 4
    end
  end

    #
    # describe 'when backend caching is disabled' do
    #   it 'returns a backend without caching' do
    #     opts = { command_runner: :generic, backend_cache: false }
    #     runner = Inspec::Runner.new(opts)
    #     backend = runner.instance_variable_get(:@backend)
    #     backend.backend.cache_enabled?(:command).must_equal false
    #   end
    #
    #   it 'returns a backend without caching as default' do
    #     backend = runner.instance_variable_get(:@backend)
    #     backend.backend.cache_enabled?(:command).must_equal false
    #   end
    # end
    #
    # describe 'when no attrs are specified' do
    #   it 'returns an empty hash' do
    #     options = {}
    #     runner.load_attributes(options).must_equal({})
    #   end
    # end
    #
    # describe 'when an attr is provided and does not resolve' do
    #   it 'raises an exception' do
    #     options = { attrs: ['nope.jpg'] }
    #     Inspec::SecretsBackend.expects(:resolve).with('nope.jpg').returns(nil)
    #     proc { runner.load_attributes(options) }.must_raise Inspec::Exceptions::SecretsBackendNotFound
    #   end
    # end
    #
    # describe 'when an attr is provided and has no attributes' do
    #   it 'returns an empty hash' do
    #     secrets = mock
    #     secrets.stubs(:attributes).returns(nil)
    #     options = { attrs: ['empty.yaml'] }
    #     Inspec::SecretsBackend.expects(:resolve).with('empty.yaml').returns(secrets)
    #     runner.load_attributes(options).must_equal({})
    #   end
    # end
    #
    # describe 'when an attr is provided and has attributes' do
    #   it 'returns a hash containing the attributes' do
    #     options = { attrs: ['file1.yaml'] }
    #     attributes = { foo: 'bar' }
    #     secrets = mock
    #     secrets.stubs(:attributes).returns(attributes)
    #     Inspec::SecretsBackend.expects(:resolve).with('file1.yaml').returns(secrets)
    #     runner.load_attributes(options).must_equal(attributes)
    #   end
    # end
    #
    # describe 'when multiple attrs are provided and one fails' do
    #   it 'raises an exception' do
    #     options = { attrs: ['file1.yaml', 'file2.yaml'] }
    #     secrets = mock
    #     secrets.stubs(:attributes).returns(nil)
    #     Inspec::SecretsBackend.expects(:resolve).with('file1.yaml').returns(secrets)
    #     Inspec::SecretsBackend.expects(:resolve).with('file2.yaml').returns(nil)
    #     proc { runner.load_attributes(options) }.must_raise Inspec::Exceptions::SecretsBackendNotFound
    #   end
    # end
    #
    # describe 'when multiple attrs are provided and one has no attributes' do
    #   it 'returns a hash containing the attributes from the valid files' do
    #     options = { attrs: ['file1.yaml', 'file2.yaml'] }
    #     attributes = { foo: 'bar' }
    #     secrets1 = mock
    #     secrets1.stubs(:attributes).returns(nil)
    #     secrets2 = mock
    #     secrets2.stubs(:attributes).returns(attributes)
    #     Inspec::SecretsBackend.expects(:resolve).with('file1.yaml').returns(secrets1)
    #     Inspec::SecretsBackend.expects(:resolve).with('file2.yaml').returns(secrets2)
    #     runner.load_attributes(options).must_equal(attributes)
    #   end
    # end
    #
    # describe 'when multiple attrs are provided and all have attributes' do
    #   it 'returns a hash containing all the attributes' do
    #     options = { attrs: ['file1.yaml', 'file2.yaml'] }
    #     secrets1 = mock
    #     secrets1.stubs(:attributes).returns({ key1: 'value1' })
    #     secrets2 = mock
    #     secrets2.stubs(:attributes).returns({ key2: 'value2' })
    #     Inspec::SecretsBackend.expects(:resolve).with('file1.yaml').returns(secrets1)
    #     Inspec::SecretsBackend.expects(:resolve).with('file2.yaml').returns(secrets2)
    #     runner.load_attributes(options).must_equal({ key1: 'value1', key2: 'value2' })
    #   end
    # end
  # end
end
