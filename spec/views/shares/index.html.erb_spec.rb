require 'rails_helper'

RSpec.describe "shares/index", type: :view do
  before(:each) do
    assign(:shares, [
      Share.create!(
        :user_id => 2,
        :friend_id => 3,
        :event_id => 4,
        :event => "Event"
      ),
      Share.create!(
        :user_id => 2,
        :friend_id => 3,
        :event_id => 4,
        :event => "Event"
      )
    ])
  end

  it "renders a list of shares" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Event".to_s, :count => 2
  end
end
