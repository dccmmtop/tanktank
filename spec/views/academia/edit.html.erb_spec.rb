require 'rails_helper'

RSpec.describe "academia/edit", type: :view do
  before(:each) do
    @academium = assign(:academium, Academium.create!(
      :name => "MyString",
      :local => "MyString",
      :code => "MyString",
      :superior_department => "MyString",
      :level => "MyString",
      :remark => "MyString",
      :website => "MyString",
      :address => "MyString",
      :email => "MyString",
      :brief => "MyString"
    ))
  end

  it "renders the edit academium form" do
    render

    assert_select "form[action=?][method=?]", academium_path(@academium), "post" do

      assert_select "input#academium_name[name=?]", "academium[name]"

      assert_select "input#academium_local[name=?]", "academium[local]"

      assert_select "input#academium_code[name=?]", "academium[code]"

      assert_select "input#academium_superior_department[name=?]", "academium[superior_department]"

      assert_select "input#academium_level[name=?]", "academium[level]"

      assert_select "input#academium_remark[name=?]", "academium[remark]"

      assert_select "input#academium_website[name=?]", "academium[website]"

      assert_select "input#academium_address[name=?]", "academium[address]"

      assert_select "input#academium_email[name=?]", "academium[email]"

      assert_select "input#academium_brief[name=?]", "academium[brief]"
    end
  end
end
