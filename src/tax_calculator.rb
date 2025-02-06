require_relative 'tax_rules'

class TaxCalculator
  def initialize(transaction)
    @transaction = transaction
  end

  def calculate_tax
    TaxRules.apply(@transaction)
  end
end
