require 'rails_helper'

RSpec.describe GroupsProject, type: :model do
  let(:name) { 'simple name' }
  let(:user) { User.create(name: 'Chukw', email: 'chukw@hotmail.com', id: 4) }
  let(:pr1) { Project.new(name: 'Project1', duration: 51) }
  let(:pr2) { Project.new(name: 'Project2', duration: 52) }
  let(:group) { Group.create(name: 'Group1', user_id: user.id) }

  describe 'Groups have projects ' do
    it 'Project can belong to a group' do
      pr1.group_ids = group.id
      pr1.save
      group.save

      expect(group.project_ids).to eq([pr1.id])
    end

    it 'Group can have many projects' do
      pr1.group_ids = group.id
      pr1.save
      pr2.group_ids = group.id
      pr2.save
      group.save

      expect(group.project_ids).to eq([pr1.id, pr2.id])
    end

    it 'Group projects assosiation exists' do
      pr1.group_ids = group.id
      pr1.save
      pr2.group_ids = group.id
      pr2.save
      group.save

      expect(GroupsProject.count).to eq(2)
    end
  end
end
