# Flight Booker

One way [flight booking project](https://www.theodinproject.com/lessons/ruby-on-rails-flight-booker) from 
[The Odin Project's](https://www.theodinproject.com/) Ruby on Rails curriculum.

View a live version of the site here.

# Goals

Work with drop downs, radio buttons, and nested forms.

## Requirements

- Search available flights by destination and arrival airports, number of passengers, and departure date
- Use flight search results to book a flight
- Require information for all passengers when booking a flight

## Configuration
ActiveRecord will disable referential integrity while inserting and deleting fixtures.  In order for this to work, the test database user defined in database.yml must have the super user role in the test database.