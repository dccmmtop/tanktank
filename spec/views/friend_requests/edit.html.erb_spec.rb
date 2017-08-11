require 'rails_helper'

RSpec.describe "friend_requests/edit", type: :view do
  before(:each) do
    @friend_request = assign(:friend_request, FriendRequest.create!(
      :user_id => 1,
      :content => "MyString"
    ))
  end

  it "renders the edit friend_request form" do
    render

    assert_select "form[action=?][method=?]", friend_request_path(@friend_request), "post" do

      assert_select "input#friend_request_user_id[name=?]", "friend_request[user_id]"

      assert_select "input#friend_request_content[name=?]", "friend_request[content]"
    end
  end
end
