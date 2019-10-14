class UserLoadsController < ApplicationController
  def import
    UserLoad.import(params[:file])
    redirect_to root_url, notice: "Users imported."
  end
end
