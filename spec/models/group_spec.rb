require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:name) { 'simple name' }
  let(:user) { User.create(name: 'Chukwu', email: 'chukwu@hotmail.com', id: 5) }
  let(:pr1) { Project.new(name: 'Project1', duration: 51) }
  let(:pr2) { Project.new(name: 'Project2', duration: 52) }
  let(:group) { Group.create(name: 'Group1', user_id: user.id, id: 1) }
  let(:inv_group) { Group.create(user_id: user.id) }

  describe 'Group can be created and validated' do
    it 'User can create a group' do
      gp = user.groups.new(name: 'group')
      gp.save

      expect(gp).to be_valid
    end

    it 'Group validates presence of name' do
      expect(inv_group).to_not be_valid
    end

    it 'Group can have many projects' do
      pr1.group_ids = group.id
      pr1.save
      pr2.group_ids = group.id
      pr2.save
      group.save

      expect(group.project_ids).to eq([pr1.id, pr2.id])
    end
  end
end
