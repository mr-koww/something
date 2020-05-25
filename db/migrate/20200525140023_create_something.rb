class CreateSomething < ActiveRecord::Migration[5.2]
  def self.up
    create_table :somethings do |t|
      t.string :title, null: false, index: true

      t.timestamps
    end
  end

  def self.down
    drop_table :somethings
  end
end
