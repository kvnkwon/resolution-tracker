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
    redirect("/#{current_user.id}/resolutions")
  else
    session[:error] = user_resolution.errors.messages
    redirect('/resolution/new')
  end
end

# View all resolutions for a user
get '/:user_id/resolutions' do
  @user = User.find(params[:user_id])
  @resolutions = Resolution.where(user_id: params[:user_id])
  @failed_res = Resolution.where(user_id: params[:user_id], failed: true)
  if @resolutions && current_user == @user
    erb :'resolution/all'
  else
    redirect('/')
  end
end
