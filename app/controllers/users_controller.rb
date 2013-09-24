class UsersController < ApplicationController
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])    
  end
  
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update    
    @user = User.find(params[:id])
    @user.updated_at = DateTime.now
    new_attributes = params.require(:user).permit(:surname, :email, :gener, :birth_date, :city, :country, :avatar, :provider, :uid, :name)
    respond_to do |format|
      if @user.update_attributes(new_attributes)
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
