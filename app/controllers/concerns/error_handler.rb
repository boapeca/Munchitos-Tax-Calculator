module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :handle_missing_params
  end

  private

  def validate_request(params)
    return unless validate_required_params(params)
    return unless validate_buyer_type(params[:buyer_type])
    return unless validate_product_type(params[:product_type])
    nil unless validate_price(params[:price])
  end

  # validates if all required params are present in the request
  def validate_required_params(params)
    required_params = [ :buyer_location, :buyer_type, :product_type, :price ]
    missing_params = required_params.select { |param| params[param].blank? }
    unless missing_params.empty?
      render json: { error: "Missing required parameter: #{missing_params.first}" }, status: :bad_request
      return false
    end
    true
  end

  # validates buyer type to be one of the accepted values
  def validate_buyer_type(buyer_type)
    valid_buyer_types = [ "individual", "company" ]
    unless valid_buyer_types.include?(buyer_type)
      render json: { error: "Invalid buyer_type: must be 'individual' or 'company'" }, status: :bad_request
      return false
    end
    true
  end

  # validates product type to be one of the accepted values
  def validate_product_type(product_type)
        valid_product_type = [ "good", "service-digital", "service-onsite" ]
        unless valid_product_type.include?(product_type)
          render json: { error: "Invalid product_type: must be 'good' , 'service-digital' or 'service-onsite'" }, status: :bad_request
          return false
        end
        true
  end

  # validates price is above zero
  def validate_price(price)
    if price.to_f <= 0
      render json: { error: "Invalid price format" }, status: :bad_request
      return false
    end
    true
  end
end
