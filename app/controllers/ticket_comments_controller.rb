class TicketCommentsController < ApplicationController
  before_action :set_ticket_comment, only: %i[ show edit update destroy ]

  # GET /ticket_comments or /ticket_comments.json
  def index
    @ticket_comments = TicketComment.all
  end

  # GET /ticket_comments/1 or /ticket_comments/1.json
  def show
  end

  # GET /ticket_comments/new
  def new
    @ticket_comment = TicketComment.new
  end

  # GET /ticket_comments/1/edit
  def edit
  end

  # POST /ticket_comments or /ticket_comments.json
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @ticket_comment = @ticket.ticket_comments.new(ticket_comment_params)
    @ticket_comment.user = current_user

    respond_to do |format|
      if @ticket_comment.save
        format.turbo_stream
        format.html { redirect_to @ticket, notice: "Comentario añadido." }
      else
        # Si hay un error, necesitamos recargar la variable para el formulario
        format.html { render 'tickets/show', status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /ticket_comments/1 or /ticket_comments/1.json
  def update
    respond_to do |format|
      if @ticket_comment.update(ticket_comment_params)
        format.html { redirect_to @ticket_comment, notice: "Ticket comment was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket_comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_comments/1 or /ticket_comments/1.json
  def destroy
    @ticket_comment.destroy!

    respond_to do |format|
      format.html { redirect_to ticket_comments_path, status: :see_other, notice: "Ticket comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_comment
      @ticket_comment = TicketComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_comment_params
      params.require(:ticket_comment).permit(:description)
    end
end
