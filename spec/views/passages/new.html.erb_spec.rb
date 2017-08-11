require 'rails_helper'

RSpec.describe "passages/new", type: :view do
  before(:each) do
    assign(:passage, Passage.new(
      :purpose => "MyString",
      :description => "MyText",
      :help => "MyString",
      :status => 1,
      :user_id => 1
    ))
  end

  it "renders new passage form" do
    render

    assert_select "form[action=?][method=?]", passages_path, "post" do

      assert_select "input#passage_purpose[name=?]", "passage[purpose]"

      assert_select "textarea#passage_description[name=?]", "passage[description]"

      assert_select "input#passage_help[name=?]", "passage[help]"

      assert_select "input#passage_status[name=?]", "passage[status]"

      assert_select "input#passage_user_id[name=?]", "passage[user_id]"
    end
  end
end
