class ProfilesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_profile, only: [:show, :edit, :update]

  # GET /profile
  def show
  end

  # GET /profile/edit
  def edit
  end

  # PATCH/PUT /profile
  def update
    if @profile.update(profile_params)
      redirect_to '/profile', notice: '个人资料编辑成功'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find_or_initialize_by(
        user_id: current_user.id
      )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params[:profile].permit(:name, :phone, :address)
    end
end
