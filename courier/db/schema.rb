# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110422230512) do

  create_table "compania", :force => true do |t|
    t.string   "nombre"
    t.string   "urlget"
    t.string   "urlset"
    t.string   "rif"
    t.string   "direccionF"
    t.string   "telefono"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "direccions", :force => true do |t|
    t.string   "nombre"
    t.string   "avCalle"
    t.string   "resCasa"
    t.integer  "aptoNumero"
    t.string   "urban"
    t.string   "ciudad"
    t.string   "pais"
    t.string   "cPostal"
    t.float    "lat"
    t.float    "lng"
    t.integer  "personas_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empleados", :force => true do |t|
    t.string   "cargo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facturas", :force => true do |t|
    t.float    "costoTotal"
    t.float    "iva"
    t.integer  "companias_id"
    t.integer  "ordens_id"
    t.integer  "tipo_pagos_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "historicos", :force => true do |t|
    t.string   "tipo"
    t.datetime "fecha"
    t.integer  "ordens_id"
    t.integer  "direccions_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logins", :force => true do |t|
    t.string   "email"
    t.string   "nombre"
    t.string   "apellido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ordens", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "estado"
    t.string   "notificacion"
    t.date     "fecha"
    t.integer  "remoto"
    t.integer  "personas_id"
    t.integer  "empleado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paquetes", :force => true do |t|
    t.string   "nombre"
    t.float    "peso"
    t.string   "descripcion"
    t.integer  "ordens_id"
    t.integer  "personas_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personas", :force => true do |t|
    t.string   "email"
    t.string   "nombre"
    t.string   "apellido"
    t.date     "fNacimiento"
    t.integer  "empleados_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_pagos", :force => true do |t|
    t.string   "nombre"
    t.string   "nTDC"
    t.string   "cSeguridad"
    t.date     "fVencimiento"
    t.integer  "personas_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
