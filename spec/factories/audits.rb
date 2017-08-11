FactoryGirl.define do
  factory :audit do
    content "MyText"
    auditable_id "MyString"
    integer "MyString"
    auditable_type "MyString"
  end
end
