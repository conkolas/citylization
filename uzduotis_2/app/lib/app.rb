require 'sinatra/base'
require 'sinatra/partial'

require_relative "config"
require_relative "db/database"
# require_relative "server/io_server"
require_relative "user"

# EventMachine.run do
  class App < Sinatra::Base

    #for external connections
    set :bind, 'localhost'

    #setting partial includes in views
    register Sinatra::Partial
    set :partial_template_engine, :haml
    enable :partial_underscores

    #setting up database connection and websocket server
    attr_accessor :db
    @db = Database.new DATABASE_NAME
    #
    # @server = IOServer.new 3001


    #index page
    get '/' do
      haml :index
    end

    #signup form page
    get '/register' do
      haml :register, :locals => {:response => {:success => 0, :errors => {:validation => {}, :database => {}}} }
    end

    #signup action
    post '/register' do
      haml :register, :locals => {:response => User.register( params )  }
    end
  end

# end