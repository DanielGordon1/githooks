class CreateReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :releases do |t|
      t.string :tag_name
      t.datetime :released_at
      t.integer :external_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
