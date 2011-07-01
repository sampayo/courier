class CreateCompania < ActiveRecord::Migration
  def self.up
    create_table :compania do |t|
      t.string :nombre
      t.string :urlget
       t.string :urlset
      t.string :rif
      t.string :direccionF
      t.string :telefono

      t.timestamps
    end
  end

  def self.down
    drop_table :compania
  end
end
