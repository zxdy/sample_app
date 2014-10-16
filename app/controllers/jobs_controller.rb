class JobsController < ApplicationController
  def index
    store_params
    @jobs = Job.where("logdate between :start_date AND :start_date",{start_date: params[:log_date]}).paginate(page: params[:page],per_page:10)
    respond_to do |format|
      format.html
      format.js
    end
  end


  def show
    @job = Job.find(params[:id])
  end

  def new
  end

  def destroy
    @job = Job.find(params[:id]).destroy
    @jobs = Job.where("logdate between :start_date AND :start_date",{start_date: session[:start_date]}).paginate(page:session[:page],per_page:10)
    render 'jobs/index'
    session.delete(:start_date)
    session.delete(:page)
  end
end
