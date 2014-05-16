require 'spec_helper'

describe SourcesController do
  let(:user) { create :user }

  before do
    sign_in_user(user)
  end

  describe "#create" do
    context "when the source already exists" do
      let!(:source) { create :source, name: "Source" }

      it "returns the existing source" do
        post :create, source: { name: "Source" }
        expect(response.body).to eq({id: source.id, name: source.name}.to_json)
      end
    end

    context "when the source does not exist" do
      context "successful create" do
        it "returns the new source" do
          post :create, source: { name: "Source" }
          source = assigns[:source]
          expect(response.body).to eq({id: source.id, name: source.name}.to_json)
        end
      end

      context "failure to create" do
        it "returns errors" do
          post :create, source: { name: "" }
          source = assigns[:source]
          expect(response.body).to eq({errors: {name: ["can't be blank"]}}.to_json)
        end
      end
    end
  end
end