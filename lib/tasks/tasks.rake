# initialize db with sample data provided in spec
task :init_db => :environment do
	team_names = [ "The Beatles", "The Quarrymen", "Wings", "Plastic Ono Band", "Traveling Wilburys" ]

	team_names.each do |name|
		team = Team.new(:name => name)
		team.save
	end

	email_addresses = [ "paul@mccartney.org", "john@lennon.com", "george@harrison.org", "ringo@starr.org", "stu@sutcliffe.org", "linda@mccartney.org", "yoko@ono.org", "tom@petty.org", "roy@orbison.org" ]
	email_addresses.each do |email|
		member = Member.new(:email_address => email)
		member.save
	end

	beatles = Team.find_by_name("The Beatles")
	quarrymen = Team.find_by_name("The Quarrymen")
	wings = Team.find_by_name("Wings")
	plastic = Team.find_by_name("Plastic Ono Band")
	wilburys = Team.find_by_name("Traveling Wilburys")

	paul = Member.find_by_email_address("paul@mccartney.org")
	john = Member.find_by_email_address("john@lennon.com")
	george = Member.find_by_email_address("george@harrison.org")
	ringo = Member.find_by_email_address("ringo@starr.org")
	stu = Member.find_by_email_address("stu@sutcliffe.org")
	linda = Member.find_by_email_address("linda@mccartney.org")
	yoko = Member.find_by_email_address("yoko@ono.org")
	george = Member.find_by_email_address("george@harrison.org")
	tom = Member.find_by_email_address("tom@petty.org")
	roy = Member.find_by_email_address("roy@orbison.org")

	beatles.members << paul << john << george << ringo
	quarrymen.members << john << paul << stu
	wings.members << paul << linda
	plastic.members << john << yoko
	wilburys.members << george << tom << roy

	org = Organization.new(:name => "Example")
	Member.all.each do |m|
		org.members << m
	end
	org.save
end

# clear database and cache
task :clear_db => :environment do
	Organization.delete_all
	Team.delete_all
	Member.delete_all
	PairSet.delete_all
	Pair.delete_all
	Rails.cache.clear
end