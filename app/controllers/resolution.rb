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

# View all resolutions for a user
get '/:user_id/resolutions' do
  @resolutions = Resolution.where(user_id: params[:user_id])
  if @resolutions
    erb :'resolution/all'
  else
    redirect('/')
  end
end
