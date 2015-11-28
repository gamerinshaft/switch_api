require "rails_helper"

describe "Authorize" do
  describe "GET /api/v1/auth/token" do
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

    it 'correct data type' do
      expect(String === @json["response"]["auth_token"]).to be true
    end

    it 'correct token size' do
      expect(@json["response"]["auth_token"].size).to eq 22
    end

    it 'include correct word' do
      expect(@json["meta"]["message"]).to include("を作成しました")
    end
  end

  describe "POST /api/v1/auth/signup" do
    before(:all) do
      user = create(:user)
      binding.pry
    end
    it 'test' do
      expect(1+1).to be 2
    end
  end
end
