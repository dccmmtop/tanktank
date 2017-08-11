require 'rails_helper'

RSpec.describe "messages/edit", type: :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :sender => 1,
      :receiver => 1,
      :title => "MyString",
      :content => "MyText",
      :type => 1
    ))
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(@message), "post" do

      assert_select "input#message_sender[name=?]", "message[sender]"

      assert_select "input#message_receiver[name=?]", "message[receiver]"

      assert_select "input#message_title[name=?]", "message[title]"

      assert_select "textarea#message_content[name=?]", "message[content]"

      assert_select "input#message_type[name=?]", "message[type]"
    end
  end
end
