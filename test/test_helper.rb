ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def json_response
    body =  JSON.parse(response.body)
    if body.kind_of?(Array)
      body.map do |el|
        ActiveSupport::HashWithIndifferentAccess.new(el)
      end
    else
      ActiveSupport::HashWithIndifferentAccess.new(body)
    end
  end
end
