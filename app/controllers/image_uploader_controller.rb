class ImageUploaderController < ApplicationController
  def async_upload_with_index
    @upload = Image.new(:image_content => params[:Filedata])
    index = params[:index]

    unless @upload.save
      render :json => {:status => 0, :message => "Error Uploading Image!"}.to_json
    else
      render :json => {:status => 1, :img => @upload.image_url(:thumb), :img_id => @upload.id, :index => index}.to_json
    end
  end
end
