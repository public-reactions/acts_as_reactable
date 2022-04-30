# frozen_string_literal: true

RSpec.describe ActsAsReactable::Reactable do
  describe "#remove_reactions" do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    before do
      post.add_reactions(user, %w[😀 😭 😎])
    end

    it "removes one reaction" do
      expect {
        post.remove_reactions(user, "😭")
        expect(post.reactions.map(&:emoji)).to eq(%w[😀 😎])
      }.to change(ActsAsReactable::Reaction, :count).by(-1)
    end

    it "removes multiple reactions from an array" do
      expect {
        post.remove_reactions(user, %w[😭 😎])
        expect(post.reactions.map(&:emoji)).to eq(%w[😀])
      }.to change(ActsAsReactable::Reaction, :count).by(-2)
    end

    it "ignores invalid emoji" do
      expect {
        post.remove_reactions(user, %w[😭 A])
        expect(post.reactions.map(&:emoji)).to eq(%w[😀 😎])
      }.to change(ActsAsReactable::Reaction, :count).by(-1)
    end

    it "ignores non-existing reactions" do
      expect {
        post.remove_reactions(user, %w[😭 😍])
        expect(post.reactions.map(&:emoji)).to eq(%w[😀 😎])
      }.to change(ActsAsReactable::Reaction, :count).by(-1)
    end

    it "returns the self - reactable item" do
      expect(post.remove_reactions(user, %w[😀 😭])).to eq(post)
    end
  end
end
