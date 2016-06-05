# desc "Migrate the database through scripts in db/migrate directory."
#
# namespace :db do
#   task :migrate do
#     Rake::Task["db:migrate_db1"].invoke
#     Rake::Task["db:migrate_db2"].invoke
#   end
#
#   task :migrate_db1 do
#     ActiveRecord::Base.establish_connection DB1_CONF
#     ActiveRecord::Migrator.migrate("db/migrate/db1/")
#   end
#
#   task :migrate_db2 do
#     ActiveRecord::Base.establish_connection DB2_CONF
#     ActiveRecord::Migrator.migrate("db/migrate/db2/")
#   end
# end


namespace :db do
  desc "Apply db tasks in custom databases, for example  rake db:alter[db:migrate,test-es] applies db:migrate on the database defined as test-es in databases.yml"
  task :alter, [:task,:database] => [:environment] do |t, args|
    require 'activerecord'
    puts "Applying #{args.task} on #{args.database}"
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[args.database])
    Rake::Task[args.task].invoke
  end
end
