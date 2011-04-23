class CreatePaquetes < ActiveRecord::Migration
  def self.up
    create_table :paquetes do |t|
      t.string :nombre
      t.integer :peso
      t.string :descripcion
      t.references :ordens

      t.timestamps
    end
  end

  def self.down
    drop_table :paquetes
  end
end
