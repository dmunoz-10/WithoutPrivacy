class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.string :post_id, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :text, null: false

      t.timestamps
    end
  end
end
