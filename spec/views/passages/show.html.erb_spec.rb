require 'rails_helper'

RSpec.describe "passages/show", type: :view do
  before(:each) do
    @passage = assign(:passage, Passage.create!(
      :purpose => "Purpose",
      :description => "MyText",
      :help => "Help",
      :status => 2,
      :user_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Purpose/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Help/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
