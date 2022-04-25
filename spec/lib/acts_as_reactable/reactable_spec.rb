require_relative "../../spec_helper"

describe ActsAsReactable::Reactable do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe "#update_reaction_from" do
    describe "creating reaction" do
      it "creates (and returns) one reaction" do
        expect {
          reaction = post.update_reaction_from(user, "😀")
          expect(reaction).to be_a(ActsAsReactable::Reaction)
        }.to change(ActsAsReactable::Reaction, :count).by(1)
      end

      it "creates a reaction with the correct attributes" do
        post.update_reaction_from(user, "😀")

        reaction = ActsAsReactable::Reaction.last

        expect(reaction.persisted?).to be true
        expect(reaction.reactable).to eq post
        expect(reaction.reactor).to eq user
        expect(reaction.emoji).to eq "😀"
      end

      it "does not create a reaction with invalid emoji" do
        expect {
          post.update_reaction_from(user, "face")
        }.to change(ActsAsReactable::Reaction, :count).by(0)
      end
    end

    describe "updating reaction" do
      before do
        post.update_reaction_from(user, "😀")
      end

      it "updates existing reaction" do
        expect {
          post.update_reaction_from(user, "😺")
          reaction = ActsAsReactable::Reaction.last

          expect(reaction.persisted?).to be true
          expect(reaction.emoji).to eq "😺"
        }.to change(ActsAsReactable::Reaction, :count).by(1)
      end

      it "doesn't update existing reaction with invalid input" do
        expect {
          post.update_reaction_from(user, "not a emoji")
          reaction = ActsAsReactable::Reaction.last

          expect(reaction.persisted?).to be true
          expect(reaction.emoji).to eq "😀"
        }.to change(ActsAsReactable::Reaction, :count).by(0)
      end

      it "deletes reaction with empty emoji" do
        expect {
          expect(post).to receive(:destroy_reaction_from).and_call_original.with(user)
          post.update_reaction_from(user)
        }.to change(ActsAsReactable::Reaction, :count).by(-1)
      end
    end
  end

  describe "#destroy_reaction_from" do
    before do
      post.update_reaction_from(user, "😀")
    end

    it "deletes reaction with empty emoji" do
      expect(post.reactions.count).to eq 1
      expect(user.reactions.count).to eq 1

      expect {
        post.destroy_reaction_from(user)

        expect(post.reactions.count).to eq 0
        expect(user.reactions.count).to eq 0
      }.to change(ActsAsReactable::Reaction, :count).by(-1)
    end
  end
end
