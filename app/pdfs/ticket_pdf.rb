require "prawn"
require "prawn/table"

class TicketPdf < Prawn::Document

  def initialize(ticket)
    super()
    @ticket = ticket
    generate_pdf
  end

  private

  def generate_pdf
    # --- Configuración del Documento ---
    font "Helvetica"
    
    # --- Encabezado ---
    text "Detalle del Ticket ##{@ticket.id}", size: 24, style: :bold
    move_down 20
    
    # --- Tabla de Metadatos ---
    metadata = [
      ["Estado:", @ticket.status.description],
      ["Prioridad:", @ticket.priority],
      ["Equipo Asignado:", @ticket.team.description],
      ["Agente Asignado:", @ticket.assigned_to&.name || "No asignado"]
    ]
    table(metadata, cell_style: { border_width: 0, padding: [5, 0] })
    
    move_down 30
    
    # --- Descripción ---
    text "Descripción del Problema", size: 16, style: :bold
    stroke_horizontal_rule
    move_down 10
    text @ticket.description
    
    move_down 30
    
    # --- Detalles de Contacto y Ubicación ---
    text "Detalles de Contacto y Ubicación", size: 16, style: :bold
    stroke_horizontal_rule
    move_down 10
    contact_info = [
      ["Contacto:", @ticket.contact_name],
      ["Teléfono:", @ticket.contact_phone],
      ["Ubicación:", "#{@ticket.location.description}, #{@ticket.location_group.description}"]
    ]
    table(contact_info, cell_style: { border_width: 0, padding: [5, 0] })
    
    # --- Pie de Página (opcional) ---
    string = "Página <page> de <total>"
    options = { at: [bounds.right - 150, 0], width: 150, align: :right }
    number_pages string, options
  end
end
