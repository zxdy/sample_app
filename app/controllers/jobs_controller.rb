class JobsController < ApplicationController
  before_action :signed_in_user
  def index
    @jobs = Jobs.paginate(page: params[:page])
  end

  def show
    @job = Jobs.find(params[:id])
  end

  def new

  end
end
