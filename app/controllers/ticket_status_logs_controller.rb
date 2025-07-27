class TicketStatusLogsController < ApplicationController
  before_action :set_ticket_status_log, only: %i[ show edit update destroy ]

  # GET /ticket_status_logs or /ticket_status_logs.json
  def index
    @ticket_status_logs = TicketStatusLog.all
  end

  # GET /ticket_status_logs/1 or /ticket_status_logs/1.json
  def show
  end

  # GET /ticket_status_logs/new
  def new
    @ticket_status_log = TicketStatusLog.new
  end

  # GET /ticket_status_logs/1/edit
  def edit
  end

  # POST /ticket_status_logs or /ticket_status_logs.json
  def create
    @ticket_status_log = TicketStatusLog.new(ticket_status_log_params)

    respond_to do |format|
      if @ticket_status_log.save
        format.html { redirect_to @ticket_status_log, notice: "Ticket status log was successfully created." }
        format.json { render :show, status: :created, location: @ticket_status_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket_status_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_status_logs/1 or /ticket_status_logs/1.json
  def update
    respond_to do |format|
      if @ticket_status_log.update(ticket_status_log_params)
        format.html { redirect_to @ticket_status_log, notice: "Ticket status log was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket_status_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket_status_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_status_logs/1 or /ticket_status_logs/1.json
  def destroy
    @ticket_status_log.destroy!

    respond_to do |format|
      format.html { redirect_to ticket_status_logs_path, status: :see_other, notice: "Ticket status log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_status_log
      @ticket_status_log = TicketStatusLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_status_log_params
      params.require(:ticket_status_log).permit(:observation, :user_id, :ticket_id, :previous_status_id, :new_status_id)
    end
end
