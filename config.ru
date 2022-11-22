require_relative 'config/environment'
require_relative 'middleware/runtime'

use Runtime
run Simpler.application
