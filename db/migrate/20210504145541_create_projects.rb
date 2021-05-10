class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :author_id
      t.integer :duration

      t.timestamps
    end
  end
end
