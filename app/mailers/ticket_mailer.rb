class TicketMailer < ApplicationMailer
  default from: 'alertas@guacalitodelaisla.com'

  def status_update_notification(ticket, user_to_notify)
    puts "sending email..."
    @ticket = ticket
    @user = 'developerfhernandez@gmail.com' #user_to_notify @user.email
    mail(to: 'developerfhernandez@gmail.com' , subject: "Actualización en tu Ticket ##{@ticket.id}: #{@ticket.title}")
  end
end
