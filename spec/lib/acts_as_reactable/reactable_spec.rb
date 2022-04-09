require_relative "../../spec_helper"

describe ActsAsReactable::Reactable do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe "#update_reaction_from" do
    describe "creating reaction" do
      it "creates a reaction" do
        expect {
          post.update_reaction_from(user, "😀")
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
      it "updates existing reaction" do
        raise 'unimplemented'
      end

      it "deletes reaction with empty emoji" do
        raise 'unimplemented'
      end

      it "doesn't update existing reaction with invalid input" do
        raise 'unimplemented'
      end
    end
  end
end
