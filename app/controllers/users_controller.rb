# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :update_user_score, only: %i[show index edit update]
  skip_before_action :require_login, only: %i[new create index]
  before_action :skip_login, only: %i[new create]
  before_action :check_author, except: %i[index new create]

  # GET /users or /users.json
  def index
    @users = User.page params[:page]
  end

  # GET /users/1 or /users/1.json
  # def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    # p "PARAMS ", user_params
    if (used_login = User.find_by(login: user_params[:login])&.login)
      flash[:warning] = "Имя #{used_login} уже занято"
      redirect_to new_user_path
    else
      @user = User.new(user_params)

      if @user.save
        sign_in @user
        redirect_to clicker_index_path
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    # p 'user params method'
    params.require(:user).permit(:login, :password, :password_confirmation)
  end

  def check_author
    # p 'check author method'
    return unless @user.id != @current_user.id

    flash[:warning] = 'Вам запрещено это делать!'
    redirect_to root_url
  end
end
