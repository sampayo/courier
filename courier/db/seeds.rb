# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#Llenamos una tupla de la tabla compa–ia(Mysql).
Companium.create! :id => 1,
                  :nombre => 'compania1',
                  :rif => 1234567,
                  :direccionF => 'aqui esta',
                  :telefono => '5555444'
                 
Persona.create! :id => 1,
                :email => 'albertogrespan@gmail.com',
                :nombre => 'Alberto',
                :apellido => 'Grespan',
                :fNacimiento => '2006-04-26'
                  
Persona.create! :id => 2,
                :email => 'ricardo9588@gmail.com',
                :nombre => 'Ricardo',
                :apellido => 'Sampayo',
                :fNacimiento => '2006-03-26'               

Persona.create! :id => 3,
                :email => 'dreye88@gmail.com',
                :nombre => 'Drey',
                :apellido => 'Laya',
                :fNacimiento => '2006-02-26'
                
Direccion.create! :id => 1,
                  :nombre =>'casa',
                  :avCalle => 'Calle Este',
                  :resCasa => 'Mi Refugio',
                  :aptoNumero => 1,
                  :urban => 'Manzanares',
                  :ciudad => 'Caracas',
                  :pais => 'Venezuela',
                  :cPostal => '3234',
                  :lat => '10.4303',
                  :lng => '-66.8855',
                  :personas_id => 1
 
Direccion.create! :id => 2,
                  :nombre =>'casa',
                  :avCalle => 'Calle Este',
                  :resCasa => 'Mi Refugio',
                  :aptoNumero => 1,
                  :urban => 'Manzanares',
                  :ciudad => 'Caracas',
                  :pais => 'Venezuela',
                  :cPostal => '3234',
                  :lat => '10.4303',
                  :lng => '-66.8855',
                  :personas_id => 2
                  
Direccion.create! :id => 3,
                  :nombre =>'casa',
                  :avCalle => 'Calle Este',
                  :resCasa => 'Mi Refugio',
                  :aptoNumero => 1,
                  :urban => 'Manzanares',
                  :ciudad => 'Caracas',
                  :pais => 'Venezuela',
                  :cPostal => '3234',
                  :lat => '10.4303',
                  :lng => '-66.8855',
                  :personas_id => 3                
                  
