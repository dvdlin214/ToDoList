get '/users/new' do
  erb :'/users/register'
end

post '/users/new' do
  user = User.new(params[:user])
  @message = "Account Successfully Created!"
  if user.save
    session[:user_id]= user.id
    redirect '/'
  else
    @errors = user.errors.full_messages
    erb :'/users/register'
  end
end

get '/users/login' do
  erb :'/users/login'
end

post '/users/login' do
  user = User.find_by(email: params[:user][:email])
  if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect "/"
  else
    @errors = ["Invalid email/password"]
    erb :'users/login'
  end
end

get '/users/logout' do
  session.clear
  redirect '/'
end

get '/users/profile/:id' do
  @user= User.find(params[:id])
  @lists=List.where(user_id: @user.id)
  erb :'/users/show'
end
