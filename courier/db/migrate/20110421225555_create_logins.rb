class CreateLogins < ActiveRecord::Migration
  def self.up
    create_table :logins do |t|
      t.string :email
      t.string :nombre
      t.string :apellido
      t.integer :id

      t.timestamps
    end
  end

  def self.down
    drop_table :logins
  end
end
