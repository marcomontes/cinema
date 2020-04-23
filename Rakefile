require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'sequel'
require 'date'
require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('config/environment', __dir__)
end

task routes: :environment do
  Cinema::API.routes.each do |route|
    method = route.request_method.ljust(10)
    path = route.origin
    puts "     #{method} #{path}"
  end
end

namespace :db do
  # DB = Sequel.connect(adapter: :postgres, user: 'marcomontes', password: '', host: '127.0.0.1', port: '5432', database: 'cinema', max_connections: 10)
  DB = Sequel.connect(adapter: :postgres, user: 'tahahleqbotsay', password: '36626f949ef0ad18ef7911a229de433ad274692a569868588ba5c4b555f50ceb', host: 'ec2-34-202-7-83.compute-1.amazonaws.com', port: '5432', database: 'dfojpg62bhcptq', max_connections: 10)

  desc "Creates Tables"
  task :create_tables do
    puts "Creating tables..."
    
    puts "Movies"
    DB.create_table :movies do
      primary_key :id
      String :name
      String :description
      String :image_url
    end

    puts "Calendars"
    DB.create_table :calendars do
      primary_key :id
      Date :movie_date
      foreign_key :movie_id, :movies
    end

    puts "Bookings"
    DB.create_table :bookings do
      primary_key :id
      foreign_key :calendar_id, :calendars
    end
  end

  desc 'Clean data'
  task clean_data: :environment do
    calendars = DB[:calendars]
    movies    = DB[:movies]
    bookings  = DB[:bookings]

    bookings.delete
    movies.delete
    calendars.delete
  end

  desc "Populate Tables"
  task :populate_tables do    
    movies_data = [
      ['Bad Boys for Life', "Isabel Aretas, widow of cartel kingpin Benito, escapes from a Mexican prison with the aid of her son Armando. Isabel sends Armando to Miami, tasking him with recovering a substantial stash of money his father Benito had hidden, as well as assassinating the people responsible for his father's arrest and eventual death in prison. Isabel demands that Armando kill Miami detective Mike Lowrey last.", 'https://upload.wikimedia.org/wikipedia/en/9/90/Bad_Boys_for_Life_poster.jpg'],
      ['Sonic the Hedgehog', "Sonic, an extraterrestrial blue hedgehog who can run at supersonic speeds, finds himself sought after by a tribe of echidnas for his power. His guardian, Longclaw the Owl, gives him a bag of rings that can create portals to other planets, using one to send him to Earth while she protects him from the echidnas, and also gives Sonic a map to a planet filled with mushrooms to use if he finds trouble on Earth. Ten years later, Sonic enjoys a secret life near the town of Green Hills, Montana, but longs to make friends. He idolizes the local sheriff, Tom Wachowski, and his veterinarian wife, Maddie, unaware the pair are planning to relocate to San Francisco soon, as Tom has been hired by the San Francisco Police Department.", 'https://upload.wikimedia.org/wikipedia/en/thumb/c/c1/Sonic_the_Hedgehog_poster.jpg/220px-Sonic_the_Hedgehog_poster.jpg'],
      ['Dolittle', "In early Victorian era England, Dr. John Dolittle (Robert Downey Jr.) is a Welsh veterinarian who has the ability to communicate with animals. After his wife, Lily (Kasia Smutniak) dies at sea, Dolittle becomes a recluse, tending to only animals and refusing to contact or assist with other humans. One day, a boy named Tommy Stubbins (Harry Collett) accidentally shoots and wounds a squirrel named Kevin (Craig Robinson) and is guided to Dolittle for help by a macaw named Polynesia, (Poly for short) (Emma Thompson).", 'https://upload.wikimedia.org/wikipedia/en/1/1f/Dolittle_%282020_film_poster%29.png'],
      ['Birds of Prey', "After the Enchantress' defeat,[b] the Joker breaks up with Harley Quinn, throwing her out on the streets of Gotham City. She is taken in by Doc, the owner of a Taiwanese restaurant, and recovers from her relationship by cutting her hair, adopting a spotted hyena (whom she names after Bruce Wayne), and taking up roller derby.", 'https://upload.wikimedia.org/wikipedia/en/6/60/Birds_of_Prey_%28and_the_Fantabulous_Emancipation_of_one_Harley_Quinn%29.jpg'],
      ['The Invisible Man', "Trapped in a violent, controlling relationship with wealthy optics engineer and businessman Adrian Griffin, Cecilia Kass drugs him with Diazepam and escapes their home into the nearby woods to wait for her sister, Emily. After she arrives, Adrian nearly catches Cecilia, but the pair are able to escape.", 'https://upload.wikimedia.org/wikipedia/en/thumb/3/3a/The_Invisible_Man_%282020_film%29_-_release_poster.jpg/220px-The_Invisible_Man_%282020_film%29_-_release_poster.jpg'],
      ['The Gentlemen', "Big Dave, editor of the Daily Print tabloid, is snubbed by cannabis baron Mickey Pearson at a party and hires private investigator Fletcher, to investigate Pearson's links to Lord Pressfield, a Royal Duke with a heroin-addicted daughter. Fletcher offers to sell his findings (typed up as a screenplay entitled Bush) to Pearson's right-hand man, Raymond, for £20,000,000.", 'https://upload.wikimedia.org/wikipedia/en/thumb/0/06/The_Gentlemen_poster.jpg/220px-The_Gentlemen_poster.jpg'],
      ['The Call of the Wild', "During the late 19th century Gold Rush, Buck, a large, gentle St. Bernard/Scotch Collie, lives contentedly with his master, Judge Miller in Santa Clara, California. One night, Buck is abducted and shipped to the Yukon aboard a freighter. During the voyage, a crew member ill-treats him. After arriving, Buck returns a dropped harmonica to a man named John Thornton, moments before being sold to Perrault and his assistant, Francoise. They use a dog sled to deliver mail across the Yukon. Perrault hopes to make the long trek to the mail depot before the deadline. Buck is introduced to the other dogs, including the vicious pack leader, a Husky named Spitz.", 'https://upload.wikimedia.org/wikipedia/en/thumb/4/43/The_Call_of_the_Wild_poster.jpg/220px-The_Call_of_the_Wild_poster.jpg'],
      ['Onward', "In a world inhabited by mythical creatures, magic was once commonplace, though difficult to master. After technological advances over the years, magic became obsolete and was largely discarded.", 'https://upload.wikimedia.org/wikipedia/en/0/03/Onward_poster.jpg'],
      ['Tanhaji', "The film begins with the opening scene of India, also called 'Sone ki chidiya' (the golden bird). However, this golden bird was destroyed due to several invasions.", 'https://upload.wikimedia.org/wikipedia/en/thumb/3/3f/Tanaji_film_poster.jpg/220px-Tanaji_film_poster.jpg'],
      ['Tolo Tolo', "Checco is a young Apulian entrepreneur dreamer who has opened a sushi restaurant in his town Spinazzola. However, after one month, the restaurant went bankrupt and he chose to emigrate to Africa to escape from debt. Here he adapts to being a waiter in a resort in Kenya, but at the outbreak of a civil war he decides to embark on a stowaway trip on a boat for migrants to Europe and chooses to do it with his African friends. However, he would not like to return to Italy, but rather to go to Liechtenstein where banking secrecy is in force and there is a lower tax burden than in Italy.", 'https://upload.wikimedia.org/wikipedia/en/thumb/9/98/Tolo_tolo.jpg/220px-Tolo_tolo.jpg'],
    ]

    movies    = DB[:movies]
    calendars = DB[:calendars]

    movies_data.each_with_index do |movie, index|
      puts "Creating Movie: #{movie[0]}"
      movie = movies.insert(name: movie[0], description: movie[1], image_url: movie[2])
    end

    movies.each do |movie|
      puts "Creating Functions for: #{movie[:name]}"
      (Date.today..Date.today + 10).each do |day|
        calendars.insert(movie_id: movie[:id], movie_date: day)
      end
    end
  end
end
