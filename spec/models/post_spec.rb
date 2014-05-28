require 'spec_helper'

describe Post do
  describe "#liked_by?" do
    let(:user) { create :user }
    let(:source) { create :source }
    let(:quote) { create :quote, citable_type: "Source", citable_id: source.id }
    let(:post) { create :post, user: user, quote: quote }

    context "user liked the post" do
      let!(:like) { create :like, likable_type: "Post", likable_id: post.id, user: user }

      it "returns true" do
        expect(post.liked_by?(user)).to be(true)
      end
    end

    context "user has not liked the post" do
      it "returns false" do
        expect(post.liked_by?(user)).to be(false)
      end
    end
  end
end
