class TaxRules
  def self.apply(transaction)
    case transaction.product_type
    when 'good'
      apply_goods_tax(transaction)
    when 'service-digital'
      apply_digital_service_tax(transaction)
    when 'service-onsite'
      apply_onsite_service_tax(transaction)
    else
      { tax: 0, type: 'unknown' }
    end
  end

  def self.apply_goods_tax(transaction)
    if transaction.buyer_location == 'Spain'
      { tax: transaction.price * 0.21, type: 'VAT' }
    elsif EU_COUNTRIES.include?(transaction.buyer_location)
      if transaction.buyer_type == 'individual'
        vat_rate = COUNTRY_VAT_RATES[transaction.buyer_location] || 0
        { tax: transaction.price * (vat_rate / 100.0), type: 'VAT' }
      else
        { tax: 0, type: 'reverse charge' }
      end
    else
      { tax: 0, type: 'export' }
    end
  end

  def self.apply_digital_service_tax(transaction)
    if transaction.buyer_location == 'Spain'
      { tax: transaction.price * 0.21, type: 'VAT' }
    elsif EU_COUNTRIES.include?(transaction.buyer_location)
      if transaction.buyer_type == 'individual'
        vat_rate = COUNTRY_VAT_RATES[transaction.buyer_location] || 0
        { tax: transaction.price * (vat_rate / 100.0), type: 'VAT' }
      else
        { tax: 0, type: 'reverse charge' }
      end
    else
      { tax: 0, type: 'no tax' }
    end
  end

  def self.apply_onsite_service_tax(transaction)
    if transaction.service_location == 'Spain'
      { tax: transaction.price * 0.21, type: 'VAT' }
    else
      { tax: 0, type: 'no tax' }
    end
  end
end