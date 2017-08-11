require 'rails_helper'

RSpec.describe "Academia", type: :request do
  describe "GET /academia" do
    it "works! (now write some real specs)" do
      get academia_path
      expect(response).to have_http_status(200)
    end
  end
end
