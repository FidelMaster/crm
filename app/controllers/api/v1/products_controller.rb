class Api::V1::ProductsController < Api::V1::ApiController
  def index
    products = Product
      .where(is_active: true)

    render json: products.as_json(
      
    ), status: :ok
  end

end
