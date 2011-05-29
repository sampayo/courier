class CreatePaquetes < ActiveRecord::Migration
  def self.up
    create_table :paquetes do |t|
      t.string :nombre
      t.float :peso
      t.string :descripcion
      t.references :ordens
      t.references :personas

      t.timestamps
    end
  end

  def self.down
    drop_table :paquetes
  end
end
