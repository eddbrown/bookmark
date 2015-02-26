require 'sinatra/base'
require 'data_mapper'
require './app/helpers/application.rb'
require './lib/link'
require './lib/tag'
require './lib/user'

class BookmarkManager < Sinatra::Base

  require_relative 'data_mapper_setup'
  enable :sessions
  set :session_secret, 'super secret'

  helpers BookmarkUtils

  get '/' do
    @links = Link.all
    erb :index
  end

  post '/links' do
    url = params[:url]
    title = params[:title]
    tags = params[:tags].split(" ").map do |tag|
      Tag.first_or_create(:text => tag)
    end
    Link.create(:url => url, :title => title, :tags => tags )
    redirect to '/'
  end

  get '/tags/:text' do
    tag = Tag.first(:text => params[:text])
    @links = tag ? tag.links : []
    erb :index
  end

  get '/users/new' do
    erb :new_user
  end

  post '/users' do
    user = User.create(:email => params[:email],
                :password => params[:password])
    session[:user_id] = user.id
    redirect to '/'
  end

  #start the server if ruby file executed directly
  run! if app_file == $0
end
