require 'spec_helper'

describe User do
  describe "#search_by_name" do
    let!(:user1) { create :user, first_name: "Paul", last_name: "Jovanovic" }
    let!(:user2) { create :user, first_name: "Pavle", last_name: "Jovanovic" }
    let!(:user3) { create :user, first_name: "Paula", last_name: "Smith" }
    let!(:user4) { create :user, first_name: "Brandon", last_name: "Paul" }

    context "when the search string is one word long" do
      it "searches for first and last names that start with the string" do
        expect(User.search_by_name("Paul")).to eq([user1, user3, user4])
      end
    end

    context "when the search string is two or more words long" do
      it "searches for first and last names matching the string" do
        expect(User.search_by_name("Paul Jovan")).to eq([user1])
      end
    end
  end

  describe "#name" do
    let(:user) { create :user, first_name: "Paul", last_name: "Jovanovic" }

    it "combines the first and last name" do
      expect(user.name).to eq("Paul Jovanovic")
    end
  end

  describe "#follow!" do
    let(:user1) { create :user }
    let(:user2) { create :user }

    it "follows the user" do
      user1.follow!(user2)
      expect(Relationship.where(follower: user1, followed: user2).count).to eq(1)
    end
  end

  describe "#unfollow!" do
    let(:user1) { create :user }
    let(:user2) { create :user }

    context "user1 is following user2" do
      let!(:relationship) { create :relationship, follower: user1, followed: user2 }

      it "unfollows the user" do
        user1.unfollow!(user2)
        expect(Relationship.where(follower: user1, followed: user2).count).to eq(0)
      end
    end
  end

  describe "#following?" do
    let(:user1) { create :user }
    let(:user2) { create :user }

    context "user1 follows another user2" do
      let!(:relationship) { create :relationship, follower: user1, followed: user2 }

      it "returns true" do
        expect(user1.following?(user2)).to eq(true)
      end
    end

    context "user1 has yet to follow user2" do
      it "returns false" do
        expect(user1.following?(user2)).to eq(false)
      end
    end
  end
end