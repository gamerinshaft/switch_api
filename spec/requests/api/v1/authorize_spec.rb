require "rails_helper"

describe "Authorize" do
  describe "GET /api/v1/auth/token"do
    before(:all) do
      get "/api/v1/auth/token"
    end
    it 'return 200 status' do
      expect(response.status).to be 200
    end
  end
end
