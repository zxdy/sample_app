class JobsController < ApplicationController
  before_action :signed_in_user
  def index
    @jobs = Jobs.paginate(page: params[:page])
  end

  def show
    @job = Jobs.find(params[:id])
  end

  def search
    @jobs = Jobs.paginate(page: params[:page],per_page:10)
    respond_to do |format|
      format.html
      format.js
    end
  end
  def new

  end
end
