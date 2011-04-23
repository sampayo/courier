class CreateHistoricos < ActiveRecord::Migration
	def self.up
		create_table :historicos do |t|
			t.string :tipo
			t.datetime :fecha
			t.references :ordens
			t.references :direccions

			t.timestamps
		end
	end

	def self.down
		drop_table :historicos
	end
end
