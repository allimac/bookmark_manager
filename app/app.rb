ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  set :public_folder, 'public'
  register Sinatra::Flash

  get '/links' do
    @links = Link.all
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
    flash[:message] = 'Link successfully added'
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
    user = User.new(name: params[:name], email: params[:email].downcase,
            password_confirmation: params[:password_confirmation])
    user.password = params[:password]
    if user.save
      flash[:message] = "Welcome #{user.name}!"
      redirect '/links'
    else
      flash[:name] = user.name
      flash[:email] = user.email
      flash[:errors] = user.errors.inject { |sum, error| sum+'. '+error }
      redirect '/register'
    end
  end


  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
