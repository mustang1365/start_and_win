class ImageUploaderController < ApplicationController
  def async_upload_with_index
    @upload = Image.new(:image_content => params[:Filedata])
    index = params[:index]

    unless @upload.save
      render :json => {:status => 0, :message => "Error Uploading Image!"}.to_json
    else
      render :json => {:status => 1, :file_name => @upload.image_content.filename, :file_url => @upload.image_url, :file_id => @upload.id, :template_path => params[:Filedata].tempfile.path}.to_json
    end
  end
end
