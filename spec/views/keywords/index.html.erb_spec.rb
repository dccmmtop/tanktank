require 'rails_helper'

RSpec.describe "keywords/index", type: :view do
  before(:each) do
    assign(:keywords, [
      Keyword.create!(
        :name => "Name",
        :using_count => 2
      ),
      Keyword.create!(
        :name => "Name",
        :using_count => 2
      )
    ])
  end

  it "renders a list of keywords" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
