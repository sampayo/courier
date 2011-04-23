class CreateFacturas < ActiveRecord::Migration
	def self.up
		create_table :facturas do |t|
			t.string :costoTotal
			t.references :companias
			t.references :ordens
			t.references :tipo_pagos

			t.timestamps
		end
	end

	def self.down
		drop_table :facturas
	end
end
