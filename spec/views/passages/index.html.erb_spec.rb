require 'rails_helper'

RSpec.describe "passages/index", type: :view do
  before(:each) do
    assign(:passages, [
      Passage.create!(
        :purpose => "Purpose",
        :description => "MyText",
        :help => "Help",
        :status => 2,
        :user_id => 3
      ),
      Passage.create!(
        :purpose => "Purpose",
        :description => "MyText",
        :help => "Help",
        :status => 2,
        :user_id => 3
      )
    ])
  end

  it "renders a list of passages" do
    render
    assert_select "tr>td", :text => "Purpose".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Help".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
