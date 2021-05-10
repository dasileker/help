class CreateGroupsProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :groups_projects do |t|

      t.timestamps
    end
  end
end
