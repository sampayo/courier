class CreateOrdens < ActiveRecord::Migration
	def self.up
		create_table :ordens do |t|
			t.string :nombre
			t.string :apellido
			t.string :estado
			t.date :fecha
			t.references :personas

			t.timestamps
		end
	end

	def self.down
		drop_table :ordens
	end
end
