require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:user) { create :user }
  let(:post) { create :post, user: user, account: account }

  describe 'GET #index' do
    let(:token) { double(Doorkeeper::AccessToken, acceptable?: true) }

    before do
      allow(controller).to receive(:doorkeeper_token) {token} # => RSpec 3
    end

    it 'responds with 200' do
      get :index, :format => :json
      response.status.should eq(200)
    end

  end

  describe "POST #create" do
    it 'responds with 201' do
      post :create, params: { title: "This is title", body: "Lorem ipsum description", question_id: 1, tag_list: "tag1, tag2" }
      response.status.should eq(201)
    end

    it 'responds with 422' do
      post :create, params: { title: "", body: "Lorem ipsum description", question_id: 1, tag_list: "" }
      response.status.should eq(422)
    end
  end
end
