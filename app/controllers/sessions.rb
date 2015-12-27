class BookmarkManager < Sinatra::Base
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
end
