# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :server, :server => 'thin' do
  guard :shotgun do
    watch(/.+/) # watch *every* file in the directory
    watch %r{^(app|lib|views)/.*\.rb}
    watch 'config.ru'
  end
end
