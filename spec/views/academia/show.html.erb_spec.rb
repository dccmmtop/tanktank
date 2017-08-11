require 'rails_helper'

RSpec.describe "academia/show", type: :view do
  before(:each) do
    @academium = assign(:academium, Academium.create!(
      :name => "Name",
      :local => "Local",
      :code => "Code",
      :superior_department => "Superior Department",
      :level => "Level",
      :remark => "Remark",
      :website => "Website",
      :address => "Address",
      :email => "Email",
      :brief => "Brief"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Local/)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/Superior Department/)
    expect(rendered).to match(/Level/)
    expect(rendered).to match(/Remark/)
    expect(rendered).to match(/Website/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Brief/)
  end
end
