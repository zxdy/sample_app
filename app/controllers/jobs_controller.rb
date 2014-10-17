class JobsController < ApplicationController
  def index
    store_params
    search
    respond_to do |format|
      format.html
      format.js
    end
  end


  def show
    @job = Job.find(params[:id])
  end
  def edit
    @job = Job.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update

  end


  def new
  end

  def destroy
    @job = Job.find(params[:id]).destroy
    search
    render 'jobs/index'
  end

  def search
    @jobs = Job.where("logdate between :start_date AND :start_date",{start_date: session[:start_date]}).paginate(page:session[:page],per_page:10)
  end
end
