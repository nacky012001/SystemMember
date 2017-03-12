class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name, null: false
      t.string :gender, null: false
      t.integer :age
      t.string :organization
      t.string :organization_position
      t.string :email, null: false
      t.string :number
      t.string :company
      t.string :company_position
      t.string :club
      t.string :club_position
      t.string :position
      t.string :referee

      t.timestamps null: false
    end
  end
end
