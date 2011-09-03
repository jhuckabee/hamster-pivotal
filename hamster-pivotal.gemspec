Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'hamster-pivotal'
  gem.homepage           = 'http://github.com/jhuckabee/hamster-pivotal'
  gem.license            = 'Public Domain' if gem.respond_to?(:license=)
  gem.summary            = 'Import your Hamster time entries into Pivotal Tracker'
  gem.description        = 'hamster-pivotal allows you to automate the process of importing your Hamster time entries into Pivotal Tracker'

  gem.authors            = ['Josh Huckabee']
  gem.email              = 'joshhuckabee@gmail.com'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(README UNLICENSE VERSION bin/hamster-pivotal) + Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w(hamster-pivotal)
  gem.default_executable = gem.executables.first
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 1.8.7'
  gem.requirements               = []
  gem.post_install_message       = nil
end
