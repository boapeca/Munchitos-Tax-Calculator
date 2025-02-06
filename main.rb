require_relative 'src/tax_calculator'
require_relative 'src/transaction'
require_relative 'src/countries_vat'

loop do
  puts 'Enter buyer location (or type "quit" to exit):'
  buyer_location = gets.chomp
  break if buyer_location.downcase == 'quit'

  puts 'Enter buyer type (individual/company):'
  buyer_type = gets.chomp

  puts 'Enter product type (good/service-digital/service-onsite):'
  product_type = gets.chomp

  puts 'Enter price:'
  price = gets.chomp.to_f

  service_location = nil
  if product_type == 'service-onsite'
    puts 'Enter service location:'
    service_location = gets.chomp
  end

  transaction = Transaction.new(
    buyer_location: buyer_location,
    buyer_type: buyer_type,
    product_type: product_type,
    price: price,
    service_location: service_location
  )

  ## debuggin why EU countries on a goods transaction are being returned as exports
  puts "Checking: #{transaction.buyer_location} against EU_COUNTRIES"
  puts "Match found: #{EU_COUNTRIES.include?(transaction.buyer_location)}"


  calculator = TaxCalculator.new(transaction)
  tax_info = calculator.calculate_tax

  puts "Tax Amount: #{tax_info[:tax]}"
  puts "Tax Type: #{tax_info[:type]}"
  puts "\n---\n"
end
