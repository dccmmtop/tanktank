require 'rails_helper'

RSpec.describe "shares/show", type: :view do
  before(:each) do
    @share = assign(:share, Share.create!(
      :user_id => 2,
      :friend_id => 3,
      :event_id => 4,
      :event => "Event"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Event/)
  end
end
