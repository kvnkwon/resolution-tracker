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
  @resolutions = Resolution.where(user_id: params[:user_id], failed: false)
  @failed_res = Resolution.where(user_id: params[:user_id], failed: true)
  if @resolutions && current_user == @user
    erb :'resolution/all'
  else
    redirect('/')
  end
end

# View all failed resolutions for a user
get '/:user_id/grave' do
  @user = User.find(params[:user_id])
  @failed_res = Resolution.where(user_id: params[:user_id], failed: true)
  if @failed_res && current_user == @user
    erb :'resolution/failed'
  else
    redirect('/')
  end
end

# User can fail a help request
put '/resolution/:id/fail' do
  resolution = Resolution.find(params[:id])
  resolution.update(failed: true)
  erb :_failed, layout: false
end

# User can revive a  failed help request
put '/resolution/:id/revive' do
  resolution = Resolution.find(params[:id])
  resolution.update(failed: false)
  erb :_revive, layout: false
end


# Delete a resolution
delete '/resolution/:id' do
  resolution = Resolution.find(params[:id])
  resolution.destroy
  redirect("/#{current_user.id}/resolutions")
end
