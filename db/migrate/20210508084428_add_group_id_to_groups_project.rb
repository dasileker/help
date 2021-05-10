class AddGroupIdToGroupsProject < ActiveRecord::Migration[6.1]
  def change
    add_column :groups_projects, :group_id, :integer
    add_column :groups_projects, :project_id, :integer
  end
end
