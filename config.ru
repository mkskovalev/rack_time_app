require_relative 'middleware/link_handler'
require_relative 'app'

use LinkHandler
run App.new
