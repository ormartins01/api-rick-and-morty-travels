require "./config/initializers/database" 
require "sam"
require "./db/migrations/*"

load_dependencies "jennifer"

Sam.help