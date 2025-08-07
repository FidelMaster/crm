class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy assign_agent edit_billing update_status update_billing approve_billing   reject_billing mark_as_paid ]

  # GET /tickets or /tickets.json
  def index
    if current_user.admin?
      @tickets = Ticket.all
    else
      # Si no es admin, solo muestra los tickets creados por el usuario actual
       @tickets = Ticket.where(created_by: current_user)
    end 
  end

  # GET /tickets/1 or /tickets/1.json
  def show
    @agents = User.where(role: 1) 

    @ticket_products = @ticket.ticket_products.includes(:product).order("products.description")
    @ticket_product = @ticket.ticket_products.new

    @ticket_comments = @ticket.ticket_comments.order(created_at: :asc)
    @ticket_comment = @ticket.ticket_comments.new

    @ticket_statuses = TicketStatus.all
    @products = Product.where(is_active: true).order(:description)
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new

    @teams = Team.all
    @location_groups = LocationGroup.all
  end

  # GET /tickets/1/edit
  def edit
  end

  def edit_billing
    # La variable @ticket es cargada por el before_action
  end


  def update_billing
    billing_attributes = billing_params.merge(
      billable: true,
      billing_status: :pending_approval,
      invoice_generate_date: Date.current  
    )

    if @ticket.update(billing_attributes)
      redirect_to @ticket, notice: 'La información de facturación se ha guardado.'
    else
      render :edit_billing, status: :unprocessable_entity
    end
  end

  def assign_agent
    # Busca el estado "Asignado". Usamos find_by! para que falle si no lo encuentra.
    assigned_status = TicketStatus.find_by!(code: 'assigned')
    current_status = @ticket.status

    begin
    # Inicia una transacción. Todas las operaciones dentro de este bloque
    # se ejecutarán como una sola unidad.
    ActiveRecord::Base.transaction do
      # 1. Actualiza el ticket con el agente, la fecha Y el nuevo estado.
      #    Usamos update! para que falle y active el rollback si algo sale mal.
      @ticket.update!(assign_agent_params.merge(status: assigned_status))

      # 2. Crea el registro en el historial de estados del ticket.
      #    Asume que tienes un modelo TicketStatusLog.
      TicketStatusLog.create!(
        ticket: @ticket,
        new_status: assigned_status,
        previous_status: current_status,
        observation: "Cambio de #{current_status.description} a #{assigned_status.description}.",
        user: current_user # Guarda qué usuario hizo el cambio
      )
    end

    # Si la transacción fue exitosa, redirige con el mensaje de éxito.
    redirect_to @ticket, notice: 'Agente asignado y estado actualizado exitosamente.'

    rescue ActiveRecord::RecordNotFound
      # Este bloque se ejecuta si el estado "Assigned" no se encuentra.
      redirect_to @ticket, alert: 'Error: El estado "Assigned" no está configurado en el sistema.'
    rescue ActiveRecord::RecordInvalid => e
      # Este bloque se ejecuta si la actualización o la creación del log falla.
      redirect_to @ticket, alert: "No se pudo asignar el agente: #{e.message}"
    end
  end

  def update_status
    @ticket = Ticket.find(params[:id])
    new_status = TicketStatus.find(params[:ticket][:status_id])

    # Opcional pero recomendado: Crear un log del cambio de estado
    @ticket.ticket_status_logs.create(
      previous_status: @ticket.status,
      new_status: new_status,
      user: current_user,
      observation: "Cambio de #{@ticket.status.description} a #{new_status.description}.",
      
    )

    if @ticket.update(status: new_status)
      TicketMailer.status_update_notification(@ticket, @ticket.created_by).deliver_later
      
      redirect_to @ticket, notice: "El estado del ticket se ha actualizado a '#{new_status.description}'."
    else
      redirect_to @ticket, alert: "No se pudo actualizar el estado del ticket."
    end
  end

  def approve_billing
    @ticket.payment_pending!
    redirect_to @ticket, notice: 'La cotización ha sido aprobada y está pendiente de pago.'
  end

  def reject_billing
    @ticket.rejected!
    redirect_to @ticket, notice: 'La cotización ha sido rechazada.'
  end

  def mark_as_paid
    @ticket.paid!
    redirect_to @ticket, notice: 'El ticket ha sido marcado como pagado.'
  end


  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    # Asignamos automáticamente el usuario logueado y el estado inicial
    @ticket.created_by = current_user
    @ticket.status = TicketStatus.find_by(code: 'open')
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }

        @teams = Team.all
        @location_groups = LocationGroup.all
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy!

    respond_to do |format|
      format.html { redirect_to tickets_path, status: :see_other, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def assign_agent_params
      params.require(:ticket).permit(:assigned_to_id, :scheduled_date)
    end
 

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(
          :title, :description, :priority, :contact_name, :contact_phone,
          :team_id, :location_group_id, :location_id, :service_type_id
      )
    end

    def billing_params
      params.require(:ticket).permit(:cost, :invoice_contact_name, :invoice_details)
    end
end
