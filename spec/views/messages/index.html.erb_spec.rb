require 'rails_helper'

RSpec.describe "messages/index", type: :view do
  before(:each) do
    assign(:messages, [
      Message.create!(
        :sender => 2,
        :receiver => 3,
        :title => "Title",
        :content => "MyText",
        :type => 4
      ),
      Message.create!(
        :sender => 2,
        :receiver => 3,
        :title => "Title",
        :content => "MyText",
        :type => 4
      )
    ])
  end

  it "renders a list of messages" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
