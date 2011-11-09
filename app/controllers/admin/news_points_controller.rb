class Admin::NewsPointsController < Admin::AdminController
  # GET /news_points
  # GET /news_points.json
  def index
    @news_points = NewsPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_points }
    end
  end

  # GET /news_points/1
  # GET /news_points/1.json
  def show
    @news_point = NewsPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_point }
    end
  end

  # GET /news_points/new
  # GET /news_points/new.json
  def new
    @news_point = NewsPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_point }
    end
  end

  # GET /news_points/1/edit
  def edit
    @news_point = NewsPoint.find(params[:id])
  end

  # POST /news_points
  # POST /news_points.json
  def create
    @news_point = NewsPoint.new(params[:news_point])
    @news_point.cover = Image.find_by_id(params[:image_id])
    respond_to do |format|
      if @news_point.save
        format.html { redirect_to @news_point, notice: 'News point was successfully created.' }
        format.json { render json: @news_point, status: :created, location: @news_point }
      else
        format.html { render action: "new" }
        format.json { render json: @news_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news_points/1
  # PUT /news_points/1.json
  def update
    @news_point = NewsPoint.find(params[:id])

    respond_to do |format|
      if @news_point.update_attributes(params[:news_point])
        format.html { redirect_to @news_point, notice: 'News point was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @news_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_points/1
  # DELETE /news_points/1.json
  def destroy
    @news_point = NewsPoint.find(params[:id])
    @news_point.destroy

    respond_to do |format|
      format.html { redirect_to news_points_url }
      format.json { head :ok }
    end
  end
end
