FactoryGirl.define do
  factory :order do
    workflow_state "MyString"
name "MyString"
address "MyText"
city "MyString"
zipcode "MyString"
phone "MyString"
email "MyString"
comment "MyText"
shipping_method_id 1
shipping_price ""
payment_method_id 1
  end

end
