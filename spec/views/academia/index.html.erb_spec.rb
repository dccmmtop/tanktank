require 'rails_helper'

RSpec.describe "academia/index", type: :view do
  before(:each) do
    assign(:academia, [
      Academium.create!(
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
      ),
      Academium.create!(
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
      )
    ])
  end

  it "renders a list of academia" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Local".to_s, :count => 2
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Superior Department".to_s, :count => 2
    assert_select "tr>td", :text => "Level".to_s, :count => 2
    assert_select "tr>td", :text => "Remark".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Brief".to_s, :count => 2
  end
end
