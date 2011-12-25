class Admin::FileUploadController < ApplicationController
  def async_private_upload
    @upload = PrivateFile.new(:file_content => params[:Filedata])
    index = params[:index]

    unless @upload.save
      render :json => {:status => 0, :message => "Error Uploading File!"}.to_json
    else
      render :json => {:status => 1, :file_name => @upload.file_content.filename, :file_url => @upload.file_url, :file_id => @upload.id, :template_path => params[:Filedata].tempfile.path}.to_json
    end
  end

end
