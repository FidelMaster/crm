class TicketMailer < ApplicationMailer
  default from: 'alertas@guacalitodelaisla.com'

  def agent_assignment_notification(ticket)
    @ticket = ticket
    @agent = ticket.assigned_to
    
    # Asegúrate de que haya un agente asignado antes de intentar enviar el correo
    return unless @agent.present?
    
    mail(to: @agent.email, subject: "Nuevo Ticket Asignado ##{@ticket.id}: #{@ticket.title}")
  end

  def status_update_notification(ticket, user_to_notify)
    puts "sending new status email..."

    @ticket = ticket
    @user = user_to_notify
    mail(to: @user.email, subject: "Ticket ##{@ticket.id}: #{@ticket.title} | Actualizacion de estado")
  end

  def new_comment_notification(comment, user_to_notify)
    @comment = comment
    @ticket = comment.ticket
    @user_to_notify = user_to_notify
    
    mail(to: @user_to_notify.email, subject: "Nuevo comentario en el Ticket ##{@ticket.id}: #{@ticket.title}")
  end

    # Notificación para el cliente que creó el ticket
  def new_ticket_notification_to_customer(ticket)
    @ticket = ticket
    @user = ticket.created_by
    mail(to: @user.email, subject: "Hemos recibido tu Ticket ##{@ticket.id}: #{@ticket.title}")
  end

  # Notificación para el jefe del equipo asignado
  def new_ticket_notification_to_boss(ticket)
    @ticket = ticket
    @boss = ticket.team.boss
    
    # Envía el correo solo si el equipo tiene un jefe asignado
    return unless @boss.present?

    mail(to: @boss.email, subject: "Nuevo Ticket en tu área ##{@ticket.id}: #{@ticket.title}")
  end

 def billing_notification(ticket)
    @ticket = ticket
    @user = ticket.created_by  
    
    mail(to: @user.email, subject: "Cotización generada para tu Ticket ##{@ticket.id}: #{@ticket.title}")
 end
end
