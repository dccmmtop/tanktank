require 'rails_helper'

RSpec.describe "friend_requests/new", type: :view do
  before(:each) do
    assign(:friend_request, FriendRequest.new(
      :user_id => 1,
      :content => "MyString"
    ))
  end

  it "renders new friend_request form" do
    render

    assert_select "form[action=?][method=?]", friend_requests_path, "post" do

      assert_select "input#friend_request_user_id[name=?]", "friend_request[user_id]"

      assert_select "input#friend_request_content[name=?]", "friend_request[content]"
    end
  end
end
