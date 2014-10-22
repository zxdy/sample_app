class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def upload
    uploaded_io = params[:picture]
    begin
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      flash[:success] = "upload successfully"
    rescue
      flash.now[:error] = 'upload failed'
    end
    redirect_to uploadpage_path
  end

end
