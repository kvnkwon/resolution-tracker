# Create a resolution
get '/resolution/new' do
  if current_user
    erb :'resolution/new'
  else
    redirect('/login')
  end
end

post '/resolution/new' do
  user_resolution = Resolution.create(params[:resolution])
  user_resolution.update(user_id: current_user.id)
  if user_resolution.save
    redirect("/")
  else
    session[:error] = user_resolution.errors.messages
    redirect('/resolution/new')
  end
end