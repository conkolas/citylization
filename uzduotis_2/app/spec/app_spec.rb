require 'rack/test'

require File.expand_path '../spec_helper.rb', __FILE__
require File.expand_path '../../lib/config.rb', __FILE__
require File.expand_path '../../lib/app.rb', __FILE__


describe 'App' do
  include Rack::Test::Methods

  def app
    App.new
  end

  it "displays home page" do
    get '/'
    expect(last_response.status).to eq(200)
  end
  it "displays register page" do
    get '/register'
    expect(last_response.status).to eq(200)
  end
  it "register page accepts post request" do
    post '/register', "username" => "Bryan"
    expect(last_response.status).to eq(200)
  end
end
