require 'spec_helper'

describe UsersController do
  describe "#show" do
    let(:user) { create :user }

    before do
      sign_in_user(user)
    end

    it "loads the user" do
      get :show, id: user.id
      expect(assigns[:user]).to eq(user)
    end
  end

  describe "#search" do
    let!(:user1) { create :user, first_name: "Paul", last_name: "Jovanovic" }
    let!(:user2) { create :user, first_name: "Pavle", last_name: "Jovanovic" }
    let!(:user3) { create :user, first_name: "Paula", last_name: "Smith" }
    let!(:user4) { create :user, first_name: "Brandon", last_name: "Paul" }

    before do
      sign_in_user(user1)
    end

    context "when the search string is one word long" do
      it "searches for first and last names that start with the string" do
        get :search, name: "Paul"
        expect(response.body).to eq([{id: user1.id, name: user1.name}, {id: user3.id, name: user3.name}, {id: user4.id, name: user4.name}].to_json)
      end
    end

    context "when the search string is two or more words long" do
      it "searches for first and last names matching the string" do
        get :search, name: "Paul Jovan"
        expect(response.body).to eq([{id: user1.id, name: user1.name}].to_json)
      end
    end
  end
end