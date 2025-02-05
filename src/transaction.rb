class Transaction
  attr_reader :buyer_location, :buyer_type, :product_type, :price, :service_location

  def initialize(buyer_location:, buyer_type:, product_type:, price:, service_location: nil)
    @buyer_location = buyer_location
    @buyer_type = buyer_type
    @product_type = product_type
    @price = price
    @service_location = service_location
  end
end