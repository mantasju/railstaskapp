# frozen_string_literal: true

describe Team do
  before(:each) do
    @owner_user = User.create(
      username: 'labas',
      password: 'krabas',
      email: 'a@a.a',
      age: 12
    )
    allow(LoginHelper).to receive(:logged_in_user).and_return(@owner_user)
    @user = User.create(
      username: 'baduser',
      password: 'badpassword',
      email: 'a@a.a',
      age: 12
    )
    @team = Team.new(
      size: 5,
      name: 'nice_team'
    )
  end

  context 'initialize' do
    it 'should have the assigned team size after creation' do
      expect(@team.size).to eq(5)
    end
    it 'should have the correct team owner after creation' do
      expect(@team.team_owner).to eq(@owner_user)
    end
    it 'should have the correct team name after creation' do
      expect(@team.name).to eq('nice_team')
    end
  end

  context 'equals' do
    it 'two teams eq if the owner is the same and name is the same' do
      new_team = Team.new(
        size: 5,
        name: 'nice_team'
      )

      expect(new_team).to eq(@team)
    end

    it 'two teams not eq if the owner is the same but name is not' do
      new_team = Team.new(
        size: 5,
        name: 'nicee_team'
      )

      expect(new_team).not_to eq @team
    end

    it 'two teams not eq if the owner is not the same but the name is' do
      user = User.create(
        username: 'loluser',
        password: 'lolpassword',
        email: 'a@a.a',
        age: 12
      )
      allow(LoginHelper).to receive(:logged_in_user).and_return(user)
      new_team = Team.new(
        size: 5,
        name: 'nice_team'
      )

      expect(new_team).not_to eq @team
    end
  end

  context 'team owner' do
    it 'should only allow team owner to change team owner' do
      allow(LoginHelper).to receive(:logged_in_user).and_return(@user)

      expect { @team.change_team_owner(@user) }
        .to raise_error('Only team owner can change the team owner')
    end
    it 'should change team owner' do
      @team.change_team_owner(@user)
      expect(@team.team_owner).to eq(@user)
    end

    it 'should not allow to change team owner to nil' do
      expect { @team.change_team_owner(nil) }
        .to raise_error('New team owner can\'t be nil')
    end
  end

  context 'add members' do

    it 'should not allow action if you are not team owner' do
      allow(LoginHelper).to receive(:logged_in_user).and_return(@user)
      expect { @team.add_team_member(@user) }
        .to raise_error('You are not the team owner')
    end

    it 'should not allow to add the same user twice' do
      @team.add_team_member(@user)
      expect { @team.add_team_member(@user) }
        .to raise_error('User is already on the team')
    end

    it 'should not allow to add new members after reached limit' do
      expect do
        (1..10).to_a.each do |i|
          user = User.create(
            username: "#{i}a.join}",
            password: 'asd',
            email: 'a@a.a',
            age: 15
          )
          @team.add_team_member(user)
        end
      end.to raise_error('Team is already full')
    end

    it 'should not allow to add a nil member' do
      expect { @team.add_team_member(nil) }
        .to raise_error('User to add cannot be nil')
    end

    it 'should succesfully add a member' do
      @team.add_team_member(@user)
      expect(@team.player_on_team?(@user)).to be true
    end
  end

  context 'remove members' do

    it 'should try to get the logged in user while trying to remove' do
      expect(LoginHelper).to receive(:logged_in_user)

      @team.add_team_member(@user)
      @team.remove_team_member(@user)
      expect(@team.player_on_team?(@user)).to be false
    end

    it 'should not allow allow action if you are not team owner' do
      allow(LoginHelper).to receive(:logged_in_user).and_return(@user)

      expect { @team.remove_team_member(@user) }
        .to raise_error('You are not the team owner')
    end

    it 'should succesfully remove a member' do
      @team.add_team_member(@user)
      @team.remove_team_member(@user)
      expect(@team.player_on_team?(@user)).to be false
    end
  end
end
