# frozen_string_literal: true

require_relative '../lib/gilded_require'

# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  # config.example_status_persistence_file_path = 'spec/specs.txt'
  # config.define_derived_metadata(file_path: /exchange_it\/utils/) do |meta|
  #   meta[:fast] = true
  # end

  # config.filter_run_excluding :win_only unless RUBY_PLATFORM.match?(/jruby/i)
end
