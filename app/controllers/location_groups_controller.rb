class LocationGroupsController < ApplicationController
  before_action :set_location_group, only: %i[ show edit update destroy ]

  # GET /location_groups or /location_groups.json
  def index
    @location_groups = LocationGroup.all
  end

  # GET /location_groups/1 or /location_groups/1.json
  def show
  end

  # GET /location_groups/new
  def new
    @location_group = LocationGroup.new
  end

  # GET /location_groups/1/edit
  def edit
  end

  # POST /location_groups or /location_groups.json
  def create
    @location_group = LocationGroup.new(location_group_params)

    respond_to do |format|
      if @location_group.save
        format.html { redirect_to @location_group, notice: "Location group was successfully created." }
        format.json { render :show, status: :created, location: @location_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_groups/1 or /location_groups/1.json
  def update
    respond_to do |format|
      if @location_group.update(location_group_params)
        format.html { redirect_to @location_group, notice: "Location group was successfully updated." }
        format.json { render :show, status: :ok, location: @location_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_groups/1 or /location_groups/1.json
  def destroy
    @location_group.destroy!

    respond_to do |format|
      format.html { redirect_to location_groups_path, status: :see_other, notice: "Location group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_group
      @location_group = LocationGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_group_params
      params.require(:location_group).permit(:description)
    end
end
