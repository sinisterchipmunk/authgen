require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/authgen'

Hoe.plugin :newgem

$hoe = Hoe.spec 'authgen' do
  self.developer 'Colin MacKenzie IV', 'sinisterchipmunk@gmail.com'
  self.extra_deps         = [['declarative_authorization','>= 0.4.1'],
                             ['authlogic','>= 2.1.3'],
                             ['rails', '>=2.3.5']]

end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }
