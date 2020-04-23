# Cinema Project 
###### Small API for movie ticket booking

##### Project Requirements:
``ruby 2.5.7, PostgreSQL``


##### How to run this project locally:
1. Clone the repository
2. Run this commands:
* ``bundle install``
* ``rake db:create_tables``
* ``rake db:populate_tables``
3. Setup postgres database connection using this file:
``config/db_setup.rb`` and `Rakefile:25`
4. Run **rack** server using: ``rackup``

##### Some useful commands/links:
* Run Tests: ``rake spec``
* Clean the database: ``rake db:clean_data``
* Run Rack Console: ``racksh``
* [Heroku version of this project](https://cinema-rack.herokuapp.com/)
* Postman collection: [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/2aa760def6c1ea960c21)

##### API Endpoints examples:
---

```javascript
// Get movies by week day
GET http://localhost:9292/api/movies

  {
    "day": 4
  }
    
RESPONSE

    [
        {
            "id": 1,
            "name": "Bad Boys for Life",
            "description": "Isabel Aretas, widow of cartel kingpin Benito, escapes from a Mexican prison with the aid of her son Armando. Isabel sends Armando to Miami, tasking him with recovering a substantial stash of money his father Benito had hidden, as well as assassinating the people responsible for his father's arrest and eventual death in prison. Isabel demands that Armando kill Miami detective Mike Lowrey last.",
            "image_url": "https://upload.wikimedia.org/wikipedia/en/9/90/Bad_Boys_for_Life_poster.jpg"
        },
        {
            "id": 2,
            "name": "Sonic the Hedgehog",
            "description": "Sonic, an extraterrestrial blue hedgehog who can run at supersonic speeds, finds himself sought after by a tribe of echidnas for his power. His guardian, Longclaw the Owl, gives him a bag of rings that can create portals to other planets, using one to send him to Earth while she protects him from the echidnas, and also gives Sonic a map to a planet filled with mushrooms to use if he finds trouble on Earth. Ten years later, Sonic enjoys a secret life near the town of Green Hills, Montana, but longs to make friends. He idolizes the local sheriff, Tom Wachowski, and his veterinarian wife, Maddie, unaware the pair are planning to relocate to San Francisco soon, as Tom has been hired by the San Francisco Police Department.",
            "image_url": "https://upload.wikimedia.org/wikipedia/en/thumb/c/c1/Sonic_the_Hedgehog_poster.jpg/220px-Sonic_the_Hedgehog_poster.jpg"
        }
    ]
```
```javascript
// Booking list within a date range
GET http://localhost:9292/api/bookings

    {
        "init_date": "2020-04-22",
        "end_date": "2020-04-25"
    }
    
RESPONSE
  
    [
        {
            "movie": "Sonic the Hedgehog",
            "date": "2020-04-26",
            "bookings": 10
        },
        {
            "movie": "Bad Boys for Life",
            "date": "2020-04-29",
            "bookings": 2
        }
    ]
    
```
```javascript
// Create a movie
POST http://localhost:9292/api/movies

    {
        "movie": {
            "name": "No Time to Die 2",
            "description": "Recruited to rescue a kidnapped scientist, globe-trotting spy James Bond finds himself hot on the trail of a mysterious villain, who's armed with a dangerous new technology.",
            "image_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3FIXs2TB2e7fToTo8_rSMygr7-OjR0DhfLpj7QVk1TH2RGaUc"
        },
        "dates": ["2020-04-24", "2020-04-25", "2020-04-26"]
    }
    
RESPONSE

    {
        "movie": {
          "id": 11,
            "name": "No Time to Die 2",
            "description": "Recruited to rescue a kidnapped scientist, globe-trotting spy James Bond finds himself hot on the trail of a mysterious villain, who's armed with a dangerous new technology.",
            "image_url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3FIXs2TB2e7fToTo8_rSMygr7-OjR0DhfLpj7QVk1TH2RGaUc"
        },
        "dates": ["2020-04-24", "2020-04-25", "2020-04-26"]
    }
    
```
```javascript
// Create a booking with date
POST http://localhost:9292/api/bookings

    {
        "movie_id": 1,
        "date": "2020-04-30"
    }
    
RESPONSE
    {
        "booking": {
          "id": 13
        }
        "movie": "Bad Boys for Life",
        "date": "2020-04-30"
    }
    
```

##### References:
* [Rack](https://github.com/rack/rack)
* [Grape](https://github.com/ruby-grape/grape)
* [Sequel](https://github.com/jeremyevans/sequel)
* [Dry-Transaction](https://github.com/dry-rb/dry-transaction)
