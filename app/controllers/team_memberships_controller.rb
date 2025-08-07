class TeamMembershipsController < ApplicationController
  before_action :set_team_membership, only: %i[ show edit update destroy ]

  # GET /team_memberships or /team_memberships.json
  def index
    @team_memberships = TeamMembership.all
  end

  # GET /team_memberships/1 or /team_memberships/1.json
  def show
  end

  # GET /team_memberships/new
  def new
    @team_membership = TeamMembership.new

    @agents = User.where(role: 1) 
    @teams = Team.all
  end

  # GET /team_memberships/1/edit
  def edit
  end

  # POST /team_memberships or /team_memberships.json
  def create
    @team_membership = TeamMembership.new(team_membership_params)

    respond_to do |format|
      if @team_membership.save
        format.html { redirect_to @team_membership, notice: "Team membership was successfully created." }
        format.json { render :show, status: :created, location: @team_membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_memberships/1 or /team_memberships/1.json
  def update
    respond_to do |format|
      if @team_membership.update(team_membership_params)
        format.html { redirect_to @team_membership, notice: "Team membership was successfully updated." }
        format.json { render :show, status: :ok, location: @team_membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_memberships/1 or /team_memberships/1.json
  def destroy
    @team_membership.destroy!

    respond_to do |format|
      format.html { redirect_to team_memberships_path, status: :see_other, notice: "Team membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_membership
      @team_membership = TeamMembership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_membership_params
      params.require(:team_membership).permit(:team_id, :user_id)
    end
end
