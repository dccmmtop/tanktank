FactoryGirl.define do
  factory :message do
    sender 1
    receiver 1
    title "MyString"
    content "MyText"
    type 1
  end
end
