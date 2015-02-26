require 'sinatra/base'
require 'data_mapper'
require './app/helpers/application.rb'
require './app/models/link'
require './app/models/tag'
require './app/models/user'
require 'rack-flash'
require 'sinatra/partial'

require_relative 'controllers/application'
require_relative 'controllers/links'
require_relative 'controllers/sessions'
require_relative 'controllers/tags'
require_relative 'controllers/users'

require_relative 'data_mapper_setup'



class BookmarkManager < Sinatra::Base

  enable :sessions
  set :root, File.dirname(__FILE__)
  set :views, Proc.new { File.join(root, '/views')}
  set :session_secret, 'super secret'
  set :partial_template_engine, :erb

  use Rack::Flash
  use Rack::MethodOverride
  helpers BookmarkUtils


  #start the server if ruby file executed directly
  run! if app_file == $0
end
