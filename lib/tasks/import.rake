require 'csv'

desc "Export Emails to a .csv file"
task :export_order_emails => :environment do
  @orders = Order.where(workflow_state: 'delivered')

  csv_string = CSV.generate do |csv|
    csv << ["id", "email", "phone"]
    @orders.each do |order|
      csv << [
        order.id,
        order.email,
        order.phone
      ]
    end
  end
  filename = "all_order_email.csv"
  open("#{Rails.root}/lib/#{filename}", 'w') do |f|
    f.write(csv_string)
  end
end
