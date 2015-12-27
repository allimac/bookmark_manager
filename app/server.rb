class BookmarkManager < Sinatra::Base
  register Sinatra::Flash
  register Sinatra::Partial
  use Rack::MethodOverride
  enable :sessions
  set :views, File.expand_path('../views', __FILE__)
  set :partial_template_engine, :erb
  set :session_secret, 'super secret'
  set :public_folder, 'public'

  enable :partial_underscores

  helpers do
    def current_user
      @current_user ||= get.User(session[:user_id])
    end
  end
  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
