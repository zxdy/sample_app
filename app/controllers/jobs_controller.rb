class JobsController < ApplicationController
  before_action :signed_in_user
  def index
    @jobs = Job.paginate(page: params[:page])
  end

  def show
    @job = Job.find(params[:id])
  end

  def search
    @jobs = Job.where("logdate between :start_date AND :start_date",{start_date: params[:log_date]}).paginate(page: params[:page],per_page:10)
    respond_to do |format|
      format.html
      format.js
    end
  end
  def new

  end
end
