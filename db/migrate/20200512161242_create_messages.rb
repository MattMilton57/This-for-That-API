class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :recipient
      t.string :offering_type
      t.integer :offering_id
      t.string :message

      t.timestamps
    end
  end
end
