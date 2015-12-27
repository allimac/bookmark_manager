ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  set :public_folder, 'public'
  register Sinatra::Flash
  use Rack::MethodOverride

  get '/links' do
    @links = Link.all
    @user = User.get(session[:user_id])
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(title: params[:title], url: params[:url])
    params[:tag].split(/[,+ *]+/).each do |tag_name|
      tag = Tag.first_or_create(name: tag_name)
      link.tags << tag
    end
    link.save
    flash[:message] = :link_added
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    @user = User.new(name: params[:name], email: params[:email].downcase,
            password_confirmation: params[:password_confirmation])
    @user.password = params[:password]
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = :welcome
      redirect '/links'
    else
      flash[:name] = @user.name
      flash[:email] = @user.email
      flash[:errors] = @user.errors.full_messages
      redirect '/register'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:message] = :welcome_back
      redirect '/links'
    else
      flash[:errors] = 'Email or password are incorrect'
      redirect '/sessions/new'
    end
  end

  delete '/sessions/logout' do
    flash[:message] = :goodbye
    session[:user_id] = nil
    redirect '/links'
  end


  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
