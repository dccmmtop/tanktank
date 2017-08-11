require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :name => "MyString",
      :date => "MyString",
      :address => "MyString",
      :description => "MyText",
      :description_html => "MyText",
      :contact => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_name[name=?]", "event[name]"

      assert_select "input#event_date[name=?]", "event[date]"

      assert_select "input#event_address[name=?]", "event[address]"

      assert_select "textarea#event_description[name=?]", "event[description]"

      assert_select "textarea#event_description_html[name=?]", "event[description_html]"

      assert_select "input#event_contact[name=?]", "event[contact]"

      assert_select "input#event_user_id[name=?]", "event[user_id]"
    end
  end
end
