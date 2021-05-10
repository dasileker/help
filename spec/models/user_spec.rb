require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { 'simple name' }
  let(:user) { User.create(name: 'Chu', email: 'chu@hotmail.com', id: 1) }
  let(:user2) { User.create(name: 'Jake', email: 'jake@hotmail.com', id: 2) }
  let(:user_no_name) { User.create(email: 'spongeb@hotmail.com') }
  let(:user_no_email) { User.create(name: 'SpongeBob') }
  let(:pr1) { Project.new(name: 'Project1', duration: 51) }
  let(:pr2) { Project.new(name: 'Project2', duration: 52) }
  let(:group) { Group.create(name: 'Group1', user_id: user.id) }

  describe 'Users can be created' do
    it 'User validates presence of name' do
      user_no_name.save

      expect(user_no_name).to_not be_valid
    end

    it 'User validates presence of email' do
      user_no_email.save

      expect(user_no_email).to_not be_valid
    end

    it 'A user can create an project' do
      pr = Project.new(name: 'Project', duration: 50)
      pr.author_id = user.id
      pr.save

      expect(pr).to be_valid
    end

    it 'A user can have many projects' do
      pr1.author_id = user.id
      pr1.save
      pr2.author_id = user.id
      pr2.save

      expect(Project.first.author_id).to eq(user.id)
      expect(Project.second.author_id).to eq(user.id)
    end

    it 'User can create a group' do
      gp = user.groups.new(name: 'group')
      gp.save

      expect(gp).to be_valid
    end
  end
end
