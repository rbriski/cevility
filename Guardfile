# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :server, :server => 'thin' do
  guard :shotgun do
    watch(/.+/) # watch *every* file in the directory
    watch %r{^(app|lib|views)/.*\.rb}
    watch 'config.ru'
  end
end

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('ev.rb')                { "spec/features" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Capybara features specs
  watch(%r{^views/.*\.(erb|haml|slim)$})     { "spec/features" }
end


guard 'coffeescript', :input => 'lib/coffee', :output => 'public/js', :bare => true
