# frozen_string_literal: true

RSpec.describe ActsAsReactable::Reactable do
  describe "#add_reactions" do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    it "adds multiple reactions from an array" do
      expect {
        post.add_reactions(user, %w[😀 😭])
        expect(post.reactions.map(&:emoji)).to eq(%w[😀 😭])
      }.to change(ActsAsReactable::Reaction, :count).by(2)
    end

    it "adds one reaction from one emoji character" do
      expect {
        post.add_reactions(user, "😀")
        expect(post.reactions.map(&:emoji)).to eq(%w[😀])
      }.to change(ActsAsReactable::Reaction, :count).by(1)
    end

    it "ignores invalid emoji" do
      expect {
        post.add_reactions(user, %w[🔴 🟡 "A"])
        # NOTE using id not being nil to filter invalid reactions
        expect(post.reactions.where.not(id: nil).map(&:emoji)).to eq(%w[🔴 🟡])
      }.to change(ActsAsReactable::Reaction, :count).by(2)
    end

    it "ignores existing reactions" do
      post.add_reactions(user, %w[🔴 🟡])
      expect {
        post.add_reactions(user, %w[🔴 🟢 🟣])
        expect(post.reactions.map(&:emoji)).to eq(%w[🔴 🟡 🟢 🟣])
      }.to change(ActsAsReactable::Reaction, :count).by(2)
    end

    it "ignores repeating reactions" do
      expect {
        post.add_reactions(user, %w[🔴 🔴 🟢 🟣])
        expect(post.reactions.map(&:emoji)).to eq(%w[🔴 🟢 🟣])
      }.to change(ActsAsReactable::Reaction, :count).by(3)
    end

    it "returns the self - reactable item" do
      expect(post.add_reactions(user, %w[😀 😭])).to eq(post)
    end
  end
end
