require 'rails_helper'

RSpec.describe "friend_requests/index", type: :view do
  before(:each) do
    assign(:friend_requests, [
      FriendRequest.create!(
        :user_id => 2,
        :content => "Content"
      ),
      FriendRequest.create!(
        :user_id => 2,
        :content => "Content"
      )
    ])
  end

  it "renders a list of friend_requests" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
  end
end
