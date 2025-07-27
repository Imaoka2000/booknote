# frozen_string_literal: true

class UserSettingsController < ApplicationController
  before_action :set_user

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    up = params.expect(user: %i[username email profile_image password password_confirmation])
    if up[:password].blank?
      up.delete(:password)
      up.delete(:password_confirmation)
    end
    up
  end
end
