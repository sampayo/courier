class CreateOrdens < ActiveRecord::Migration
	def self.up
		create_table :ordens do |t|
			t.string :nombre
			t.string :apellido
			t.string :estado
			t.string :notificacion
			t.date :fecha
			t.integer :remoto
			t.references :personas
			t.references :empleado

			t.timestamps
		end
	end

	def self.down
		drop_table :ordens
	end
end
