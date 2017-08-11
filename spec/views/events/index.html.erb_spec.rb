require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :name => "Name",
        :date => "Date",
        :address => "Address",
        :description => "MyText",
        :description_html => "MyText",
        :contact => "Contact",
        :user_id => 2
      ),
      Event.create!(
        :name => "Name",
        :date => "Date",
        :address => "Address",
        :description => "MyText",
        :description_html => "MyText",
        :contact => "Contact",
        :user_id => 2
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Date".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Contact".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
