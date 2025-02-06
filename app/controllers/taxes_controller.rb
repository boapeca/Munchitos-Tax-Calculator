class TaxesController < ApplicationController
  require_relative '../../src/tax_calculator'
  require_relative '../../src/transaction'
  require_relative '../../src/countries_vat'

  def calculate
    # Parse request parameters
    buyer_location = params[:buyer_location]
    buyer_type = params[:buyer_type]
    product_type = params[:product_type]
    price = params[:price].to_f
    service_location = params[:service_location]

    # Create transaction object
    transaction = Transaction.new(
      buyer_location: buyer_location,
      buyer_type: buyer_type,
      product_type: product_type,
      price: price,
      service_location: service_location
    )

    # Calculate tax
    calculator = TaxCalculator.new(transaction)
    tax_info = calculator.calculate_tax

    # Render response as JSON
    render json: { tax: tax_info[:tax], tax_type: tax_info[:type] }, status: :ok
  end
end
