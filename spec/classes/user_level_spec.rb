require 'rails_helper'

describe UserLevel do
  let(:user) { create(:user, level: 1, xp: 0, email: 'asd@asd.com') }
  let(:answer) { create(:answer, item: item)}
  let(:user_level) { UserLevel.new(user, answer) }

  describe '#compute!' do
    let(:item) { create(:item, difficulty: 4) }

    context "Don't level up" do
      it 'sets the new xp and level for the user' do
        user_level.compute!

        expect(user.level).to eq 1
        expect(user.xp).to eq 4
      end
    end

    context "Level up" do
      let(:item) { create(:item, difficulty: 4) }

      it 'sets the new xp and level for the user' do
        user_level.compute!
        user_level.compute!
        expect(user.level).to eq 2
        expect(user.xp).to eq 1
      end
    end
  end

end
