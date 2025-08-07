# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if User.find_by(email: "developerfhernandez@gmail.com").nil?
  User.create!(
    name: "Fidel Hernandez",
    email: "developerfhernandez@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    role: :admin  # Usamos el enum que definimos en el modelo
  )
  puts "Usuario administrador creado: developerfhernandez@gmail.com / 123456"
else
  puts "El usuario administrador ya existe."
end


puts "Creando estados de ticket..."

TicketStatus.find_or_create_by!(code: 'open') do |status|
  status.description = 'Abierto'
end

TicketStatus.find_or_create_by!(code: 'assigned') do |status|
  status.description = 'Asignado'
end

TicketStatus.find_or_create_by!(code: 'inprogress') do |status|
  status.description = 'En progreso'
end

TicketStatus.find_or_create_by!(code: 'closed') do |status|
  status.description = 'Cerrado'
end

TicketStatus.find_or_create_by!(code: 'canceled') do |status|
  status.description = 'Cancelado'
end

puts "Estados de ticket creados/actualizados."

puts "Creando grupo de Ubicaciones"


