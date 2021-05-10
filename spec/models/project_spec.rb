require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:name) { 'simple name' }
  let(:author) { User.create(name: 'Chuk', email: 'chuk@hotmail.com', id: 3) }
  let(:pr1) { Project.new(name: 'Project1', duration: 51) }
  let(:pr2) { Project.new(name: 'Project2', duration: 52) }
  let(:group) { Group.create(name: 'Group1', user_id: author.id) }
  let(:pr_no_name) { Project.new(duration: 51) }
  let(:pr_no_duration) { Project.new(name: 'Project1') }

  describe 'Projects can be created and validated' do
    it 'A user can create an expense' do
      pr1.author_id = author.id
      pr1.save

      expect(pr1).to be_valid
    end

    it 'Project validates presence of name' do
      expect(pr_no_name).to_not be_valid
    end

    it 'Project validates presence of duration' do
      expect(pr_no_duration).to_not be_valid
    end

    it 'A user can have many projects' do
      pr1.author_id = author.id
      pr1.save
      pr2.author_id = author.id
      pr2.save

      expect(Project.first.author_id).to eq(author.id)
      expect(Project.second.author_id).to eq(author.id)
    end

    it 'Project can belong to a group' do
      pr1.group_ids = group.id
      pr1.save
      group.save

      expect(group.project_ids).to eq([pr1.id])
    end
  end
end
