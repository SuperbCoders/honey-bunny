class UpdateTransportCompanyRateTypeToIndividual < ActiveRecord::Migration
  def up
    execute("UPDATE shipping_methods SET rate_type = 'individual', rate_cents = 0 WHERE name = 'transport_company'")
  end

  def down
    execute("UPDATE shipping_methods SET rate_type = 'fix_rate', rate_cents = 50000 WHERE name = 'transport_company'")
  end
end
