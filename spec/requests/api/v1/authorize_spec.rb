require "rails_helper"

describe "Authorize" do
  describe "GET /api/v1/auth/token"do
    before(:all) do
      get "/api/v1/auth/token"
      @json = JSON.parse(response.body)
    end
    it 'return 200 status' do
      expect(response.status).to be 200
    end
    it 'meta code is same status' do
      expect(@json["meta"]["code"]).to be 200
    end
    it 'response is not nil' do
      expect(@json["response"]).not_to be_empty
    end
  end
end
