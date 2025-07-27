class TicketProductsController < ApplicationController
  before_action :set_ticket_product, only: %i[ show edit update destroy ]

  # GET /ticket_products or /ticket_products.json
  def index
    @ticket_products = TicketProduct.all
  end

  # GET /ticket_products/1 or /ticket_products/1.json
  def show
  end

  # GET /ticket_products/new
  def new
    @ticket_product = TicketProduct.new
  end

  # GET /ticket_products/1/edit
  def edit
  end

  # POST /ticket_products or /ticket_products.json
  def create
    @ticket_product = TicketProduct.new(ticket_product_params)

    respond_to do |format|
      if @ticket_product.save
        format.html { redirect_to @ticket_product, notice: "Ticket product was successfully created." }
        format.json { render :show, status: :created, location: @ticket_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_products/1 or /ticket_products/1.json
  def update
    respond_to do |format|
      if @ticket_product.update(ticket_product_params)
        format.html { redirect_to @ticket_product, notice: "Ticket product was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_products/1 or /ticket_products/1.json
  def destroy
    @ticket_product.destroy!

    respond_to do |format|
      format.html { redirect_to ticket_products_path, status: :see_other, notice: "Ticket product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_product
      @ticket_product = TicketProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_product_params
      params.require(:ticket_product).permit(:quantity, :observation, :ticket_id, :product_id)
    end
end
