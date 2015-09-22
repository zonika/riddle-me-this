desc "This task is called by the Heroku scheduler add-on"
task :send_riddles => :environment do
  User.send_questions
end

task :send_answers => :environment do
  User.send_answers
end
