# Flight Booker

One way [flight booking project](https://www.theodinproject.com/lessons/ruby-on-rails-flight-booker) from 
[The Odin Project's](https://www.theodinproject.com/) Ruby on Rails curriculum.

View a live version of the site here.  This site is configured to only have 30 days worth of flights.  Bookings can be looked up for up to 30 days after the booked flight departs.

# Requirements

- Search available flights by destination and arrival airports, number of passengers, and departure date.
- Use flight search results to book a flight.
- Require information for all passengers when booking a flight.

# Configuration
ActiveRecord will disable referential integrity while inserting and deleting fixtures.  In order for this to work, the test database user defined in database.yml must have the super user role in the test database.

# Challenges
- [Time zones](./notes/time_zones.md)
- Figuring out *where* to put certain code.
    - My rake tasks to manage data work but feel out of place.

- Factories vs. fixtures
    - I have used fixtures for airports and time zone info because they are expected to exist and rarely, if ever, change.  
    - FactoryBot is used to create flights, bookings, and passengers.

- Testing
    - Identifying what to test that is valuable.
    - This project has basic system tests for overall functionality.  
    - There are a few model tests that aren't directly tested by the system tests.  I felt they were important to include anyway to prevent specific behavior from ever happening - namely that static data (airports, time zone info) can't be changed through associations.
