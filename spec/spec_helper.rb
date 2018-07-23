require 'vcr'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  VCR.configure do |config|
    config.cassette_library_dir = "mocks/vcr_cassettes"
    config.hook_into :webmock # or :fakeweb
    config.configure_rspec_metadata!
    config.allow_http_connections_when_no_cassette = true
  end
end
