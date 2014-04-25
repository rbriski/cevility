class EV < Sinatra::Base
  def assign_number_to_current_user(number)
    begin
      @license = License.find_or_create_by_number(params[:number])
      current_user.add_license @license
      current_user.save
    rescue Sequel::UniqueConstraintViolation
      flash[:warning] = "You already have that license number"
    end
  end

  get '/license/assign' do
    erb :"license/assign"
  end

  post '/license/assign' do
    self.assign_number_to_current_user(params[:number])

    redirect '/account'
  end

  post '/user/assign/:number' do
    self.assign_number_to_current_user(params[:number])

    erb :'shared/login_license_assignment', :layout => false
  end

  # Remove the license from the current account
  get '/license/delete/:id' do
    if current_user
      license = License[params[:id]]
      license.delete
    end

    redirect '/account'
  end
end