require 'spec_helper'

describe Like do
  describe "after create" do
    let(:user) { create :user }
    let(:source) { create :source }
    let(:quote) { create :quote, citable_type: "Source", citable_id: source.id }
    let(:post) { create :post, user: user, quote: quote }
    let!(:like) { create :like, likable_type: "Post", likable_id: post.id, user: user }

    it "increment the post's like counter" do
      expect(post.reload.likes_count).to eq(1)
    end
  end

  describe "after destroy" do
    let(:user) { create :user }
    let(:source) { create :source }
    let(:quote) { create :quote, citable_type: "Source", citable_id: source.id }
    let(:post) { create :post, user: user, quote: quote }
    let!(:like) { create :like, likable_type: "Post", likable_id: post.id, user: user }

    it "decrement the post's like counter" do
      like.destroy
      expect(post.reload.likes_count).to eq(0)
    end
  end
end
