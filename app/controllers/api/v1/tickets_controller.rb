class Api::V1::TicketsController < Api::V1::ApiController
  def index
    tickets = Ticket
      .includes(
        :team,
        :status,
        :created_by,
        :assigned_to,
        :location,
        :service_type,
        :location_group,
        :ticket_comments,
        :ticket_products,
      )
      .where(assigned_to_id: current_user.id)

    render json: tickets.as_json(
      include: {
        team: { only: [:id, :description] },
        status: { only: [:id, :code, :description] },
        created_by: { only: [:id, :name, :email] },
        assigned_to: { only: [:id, :name, :email] },
        location: { only: [:id, :description] },
        service_type: { only: [:id, :description] },
        location_group: { only: [:id, :description] },
       # ticket_comments: { only: [:id, :comment, :created_at], include: { user: { only: [:id, :name] } } },
       # ticket_products: { only: [:id, :product_id, :quantity], include: { product: { only: [:id, :name] } } },
      }
    ), status: :ok
  end

  def show
    ticket = Ticket
      .includes(
        :team,
        :status,
        :created_by,
        :assigned_to,
        :location,
        :service_type,
        :location_group,
        ticket_comments: :user,
        ticket_products: :product
      )
      .find(params[:id])

    render json: ticket.as_json(
      include: {
        team: { only: [:id, :description] },
        status: { only: [:id, :code, :description] },
        created_by: { only: [:id, :name, :email] },
        assigned_to: { only: [:id, :name, :email] },
        location: { only: [:id, :description] },
        service_type: { only: [:id, :description] },
        location_group: { only: [:id, :description] },
        ticket_comments: { only: [:id, :description, :created_at], include: { user: { only: [:id, :name, :role] } } },
        ticket_products: { only: [:id, :product_id, :observation, :quantity], include: { product: { only: [:id, :sku, :description] } } },
      }
    ), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ticket no encontrado' }, status: :not_found
  end

  def add_comment
    ticket = Ticket.find(params[:id])
    ticket_comment = ticket.ticket_comments.new(description: params[:comment], user: current_user)

    if ticket_comment.save
      # notifica al agente asignado, y viceversa.
      recipient = if current_user == ticket.created_by
                    ticket.assigned_to
                  else
                    ticket.created_by
                  end
      
      # Envía el correo solo si hay un destinatario válido
      if recipient.present?
        TicketMailer.new_comment_notification(ticket_comment, recipient).deliver_later
      end

      render json: { message: 'Comentario añadido con éxito' }, status: :created
    else
      render json: { error: 'Error al añadir el comentario', details: ticket_comment.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ticket no encontrado' }, status: :not_found
  end

  def add_product
    ticket = Ticket.find(params[:id])
    product = Product.find_by(id: params[:product_id])

    unless product
      return render json: { error: 'Producto no encontrado' }, status: :not_found
    end

    ticket_product = ticket.ticket_products.new(product: product, quantity: params[:quantity], observation: params[:observation])

    if ticket_product.save
      render json: { message: 'Producto añadido con éxito al ticket' }, status: :created
    else
      render json: { error: 'Error al añadir el producto', details: ticket_product.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ticket no encontrado' }, status: :not_found
  end

  def update_status
    ticket = Ticket.find(params[:id])
    status = Status.find_by(id: params[:status_id])

    unless status
      return render json: { error: 'Estado no encontrado' }, status: :not_found
    end

    ticket_stats = ticket.ticket_status_logs.order(created_at: :desc).first
    if ticket_stats && ticket_stats.status_id == status.id
      return render json: { error: 'El ticket ya tiene este estado' }, status: :unprocessable_entity
    end

    TicketStatusLog.create(ticket: ticket, previous_status_id: ticket.status_id, new_status_id: params[:status_id], changed_by: current_user)

    if ticket.update(status: status)
      render json: { message: 'Estado del ticket actualizado con éxito' }, status: :ok
    else
      render json: { error: 'Error al actualizar el estado', details: ticket.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ticket no encontrado' }, status: :not_found
  end

  def check_arrival
    ticket = Ticket.find(params[:id])

    ticket.arrived_date =  Time.current
    ticket.longitude_arrived = params[:longitude]
    ticket.latitude_arrived = params[:latitude] 

    if ticket.save
      render json: { message: 'Estado de llegada actualizado con éxito' }, status: :ok
    else
      render json: { error: 'Error al actualizar el estado de llegada', details: ticket.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ticket no encontrado' }, status: :not_found
  end 
  
  def check_start_service
    ticket = Ticket.find(params[:id])

    ticket.start_service_date =  Time.current

    if ticket.save
      render json: { message: 'Estado de inicio de servicio actualizado con éxito' }, status: :ok
    else
      render json: { error: 'Error al actualizar el estado de inicio de servicio', details: ticket.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ticket no encontrado' }, status: :not_found
  end

  def check_end_service
    ticket = Ticket.find(params[:id])

    ticket.end_service_date =  Time.current
    ticket.longitude_end_work = params[:longitude]
    ticket.latitude_end_work = params[:latitude] 
    ticket.technical_observation = params[:technical_observation] if params[:technical_observation].present?
    if ticket.start_service_date.present?
      ticket.total_hour_service = ((ticket.end_service_date - ticket.start_service_date) / 1.hour).round(2)
    end

    if ticket.save
      render json: { message: 'Estado de fin de servicio actualizado con éxito' }, status: :ok
    else
      render json: { error: 'Error al actualizar el estado de fin de servicio', details: ticket.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ticket no encontrado' }, status: :not_found
  end

end
