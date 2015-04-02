FactoryGirl.define do
  factory :wholesale_order do
    wholesaler nil
shipping_method nil
payment_method nil
workflow_state "MyString"
paid false
city "MyString"
zipcode "MyString"
address "MyText"
name "MyString"
phone "MyString"
email "MyString"
comment "MyText"
shipping_price ""
  end

end
