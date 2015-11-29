require 'rails_helper'
require 'error_codes'

describe 'Authorize' do
  describe 'GET /api/v1/auth/token' do
    before(:all) do
      get '/api/v1/auth/token'
      @json = JSON.parse(response.body)
    end
    it 'return 200 status' do
      expect(response.status).to be 200
    end
    it 'meta status is same status' do
      expect(@json['meta']['status']).to be 200
    end
    it 'response is not nil' do
      expect(@json['response']).not_to be_empty
    end
    it 'correct data type' do
      expect(String === @json['response']['auth_token']).to be true
    end
    it 'correct token size' do
      expect(@json['response']['auth_token'].size).to eq 22
    end
    it 'include correct word' do
      expect(@json['meta']['message']).to include('を作成しました')
    end
  end

  describe 'POST /api/v1/auth/signup' do
    before(:all) do
      token = create(:auth_token)
      user = token.user
      @attributes = attributes_for(:user_info)
      @attributes.store(:auth_token, token.token)
      post '/api/v1/auth/signup', @attributes
      @json = JSON.parse(response.body)
    end
    it 'return 201 status' do
      expect(response.status).to be 201
    end
    it 'meta status is same status' do
      expect(@json['meta']['status']).to be 201
    end
    it 'response is not nil' do
      expect(@json['response']).not_to be_empty
    end
    it 'correct data type' do
      expect(String === @json['response']['auth_token']).to be true
    end
    it 'correct token size' do
      expect(@json['response']['auth_token'].size).to eq 22
    end
    it 'include correct word' do
      expect(@json['meta']['message']).to include('を登録しました')
    end
    describe 'already exist' do
      before(:all) do
        post '/api/v1/auth/signup', @attributes
        @json = JSON.parse(response.body)
      end
      it 'return 500 status' do
        expect(response.status).to be 500
      end
      it 'correct code' do
        expect(@json['meta']['errors'][0]["code"]).to be ErrorCodes::ALREADY_EXISTING
      end
    end
  end
end
