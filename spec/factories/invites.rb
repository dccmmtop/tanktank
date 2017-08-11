FactoryGirl.define do
  factory :invite do
    context "MyText"
    invitable_id 1
    invitable_type "MyString"
    user_id 1
    access_token "MyString"
    expire_at "2017-08-08 12:03:50"
    multiple false
  end
end
