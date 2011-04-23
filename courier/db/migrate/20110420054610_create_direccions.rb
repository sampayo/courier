class CreateDireccions < ActiveRecord::Migration
	def self.up
		create_table :direccions do |t|
			t.string :avCalle
			t.string :resCasa
			t.integer :aptoNumero
			t.string :urban
			t.string :ciudad
			t.string :pais
			t.string :cPostal
			t.float :lat
			t.float :lng
			t.references :personas

			t.timestamps
		end
	end

	def self.down
		drop_table :direccions
	end
end
