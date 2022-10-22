require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

module RspecApiDocumentation
  class RackTestClient < ClientBase
    def response_body
      last_response.body.encode("utf-8")
    end
  end
end

RspecApiDocumentation.configure do |config|
  config.format = :api_blueprint
  config.request_body_formatter = :json
  config.request_headers_to_include = %w[Content-Type Accept]
  config.response_headers_to_include = %w[Content-Type]
end  