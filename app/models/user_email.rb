class UserEmail < ActiveRecord::Base
  validates :email, presence: true
  validates_format_of :email, with: Devise::email_regexp

  def self.to_csv
    attributes = %w{email}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |email|
        csv << attributes.map{ |attr| email.send(attr) }
      end
    end
  end
end
