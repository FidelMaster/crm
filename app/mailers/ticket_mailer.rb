class TicketMailer < ApplicationMailer
  default from: 'alertas@guacalitodelaisla.com'

  def status_update_notification(ticket, user_to_notify)
    puts "sending email..."
    @ticket = ticket
    @user = user_to_notify
    mail(to: @user.email, subject: "Actualización en tu Ticket ##{@ticket.id}: #{@ticket.title}")
  end
end
