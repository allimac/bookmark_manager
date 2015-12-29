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

  get '/sessions/password_recover' do
    erb :'sessions/password_recover'
  end

  post '/sessions/password_recover' do
    user = User.first(:email => params[:email])
    if user
      user.generate_token
      flash.keep[:email] = params[:email]
      # Pony.mail :to => params[:email],
      #     :from => "no_reply@bookmark.com",
      #     :subject => "Password reset",
      #     :body => erb(:email_reset_password)
      redirect '/sessions/token_sent'
    else
      flash[:message] = :no_such_email
      redirect '/sessions/password_recover'
    end
  end

  get '/sessions/token_sent' do
    erb :'sessions/token_sent'
  end

  get '/sessions/password_reset/:email' do
    @email = params[:email]
    erb :'sessions/password_reset'
  end

  post '/sessions/password_reset' do

  end

end
