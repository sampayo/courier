# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
# Companium.new([{:id => 1}, {:nombre => 'compania1'}, {:rif => 1234567},
  # {:direccionF => 'aqui esta'}, {:telefono => '5555444'}])
Companium.create! :id => 1,
                  :nombre => 'compania1',
                  :rif => 1234567,
                  :direccionF => 'aqui esta',
                  :telefono => '5555444',
                  :created_at => '2011-04-26 02:39:12',
                  :updated_at => '2012-04-26 02:39:12'
