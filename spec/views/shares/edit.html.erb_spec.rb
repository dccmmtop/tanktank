require 'rails_helper'

RSpec.describe "shares/edit", type: :view do
  before(:each) do
    @share = assign(:share, Share.create!(
      :user_id => 1,
      :friend_id => 1,
      :event_id => 1,
      :event => "MyString"
    ))
  end

  it "renders the edit share form" do
    render

    assert_select "form[action=?][method=?]", share_path(@share), "post" do

      assert_select "input#share_user_id[name=?]", "share[user_id]"

      assert_select "input#share_friend_id[name=?]", "share[friend_id]"

      assert_select "input#share_event_id[name=?]", "share[event_id]"

      assert_select "input#share_event[name=?]", "share[event]"
    end
  end
end
