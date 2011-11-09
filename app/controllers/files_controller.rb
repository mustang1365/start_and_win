class FilesController < ApplicationController
  def upload_file
    @upload = Image.new(:file_content => params[:Filedata], :deleted => true)
    index = params[:index]

    unless @upload.save
      render :json => {:status => 0, :message => "Error Uploading File!"}.to_json
    else
      render :json => {:status => 1, :file_name => @upload.file_content.filename, :file_url => @upload.file_url, :file_id => @upload.id, :index => index}.to_json
    end
  end

end
