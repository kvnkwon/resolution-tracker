class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string :title
      t.references :user
      t.boolean :failed, default: false

      t.timestamps
    end
  end
end
