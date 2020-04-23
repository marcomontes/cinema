require 'spec_helper'

describe Cinema::API do
  include Rack::Test::Methods

  def app
    Cinema::App.instance
  end

end
