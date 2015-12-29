class BookmarkManager < Sinatra::Base
  get '/register' do
    erb :register
  end

  post '/register' do
    @user = User.new(email: params[:email].downcase,
            password_confirmation: params[:password_confirmation])
    @user.password = params[:password]
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = :welcome
      redirect '/links'
    else
      flash[:email] = @user.email
      flash[:errors] = @user.errors.full_messages
      redirect '/register'
    end
  end
end
