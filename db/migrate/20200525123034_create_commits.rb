class CreateCommits < ActiveRecord::Migration[6.0]
  def change
    create_table :commits do |t|
      t.text :message
      t.string :sha
      t.datetime :committed_at
      t.jsonb :ticket_identifiers, default: {}
      t.string :repository_name
      t.references :user, null: false, foreign_key: true
      t.references :release, foreign_key: true

      t.timestamps
    end
  end
end
