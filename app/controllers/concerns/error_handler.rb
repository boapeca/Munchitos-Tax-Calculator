module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :handle_missing_params
  end

  private

  def validate_request(params)
    # Return false if any validation fails, stopping further execution
    if (error = validate_required_params(params))
      render json: { error: error }, status: :bad_request
      return false
    end

    if (error = validate_buyer_type(params[:buyer_type]))
      render json: { error: error }, status: :bad_request
      return false
    end

    if (error = validate_product_type(params[:product_type]))
      render json: { error: error }, status: :bad_request
      return false
    end

    if (error = validate_price(params[:price]))
      render json: { error: error }, status: :bad_request
      return false
    end

    if params[:product_type] == "service-onsite"
      if (error = validate_service_location(params[:service_location]))
        render json: { error: error }, status: :bad_request
        return false
      end
    end

    true  # All validations passed
  end

  # validates if all required params are present in the request
  def validate_required_params(params)
    required_params = [ :buyer_location, :buyer_type, :product_type, :price ]
    missing_param = required_params.find { |param| params[param].blank? }
    "Missing required parameter: #{missing_param}" if missing_param
  end

  # validates buyer type to be one of the accepted values
  def validate_buyer_type(buyer_type)
    valid_buyer_types = [ "individual", "company" ]
    "Invalid buyer_type: must be 'individual' or 'company'" unless valid_buyer_types.include?(buyer_type)
  end

  # validates product type to be one of the accepted values
  def validate_product_type(product_type)
    valid_product_type = [ "good", "service-digital", "service-onsite" ]
    "Invalid product_type: must be 'good' , 'service-digital' or 'service-onsite'" unless valid_product_type.include?(product_type)
  end

  # validates price is above zero
  def validate_price(price)
    "Invalid price format" if price.to_f <= 0
  end

  # validates service location isnt null on service onsite
  def validate_service_location(service_location)
    "Service location cannot be null or missing for service-onsite products" if service_location.blank?
  end
end
