require 'rails_helper'

RSpec.describe "keywords/show", type: :view do
  before(:each) do
    @keyword = assign(:keyword, Keyword.create!(
      :name => "Name",
      :using_count => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
