# Three Cheers for Timezones

## Problem
When a user living on the east coast of the US wants to find a local flight departing at 10:00 PM on 6/1/2022, they'd search for 6/1/2022.  Makes sense, right? We have the date parameter as a string and can create a `Time` object with that. We use `Time.zone.parse` rather than `Time.parse` to use the time zone configured in Rails.  This is UTC by [default](https://github.com/rails/rails/blob/3872bc0e54d32e8bf3a6299b0bfe173d94b072fc/railties/lib/rails/application/configuration.rb#L49).

```
selected_date = Time.zone.parse("2022-06-01")
=> Sat, 11 Jun 2022 00:00:00.000000000 UTC +00:00
```

Rails makes it very easy to search a model's date time field in a range with the `all_day` method.

```
selected_date.all_day

=>
Sat, 11 Jun 2022 00:00:00.000000000 UTC +00:00                                  
..
Sat, 11 Jun 2022 23:59:59.999999999 UTC +00:00
```

This date range can be passed into a search:
`Flight.where(departure_date: selected_date.all_day)`

Voila! We have the day's flights. Wait... the user knows there is a daily 10:00 PM flight that isn't showing in the search results.  Why? 

A 6/1/2022 10:00 PM flight on the east coast is really 6/2/2022 2:00 AM in UTC time.  That's why our `selected_date.all_day` missed this flight.

```
flight_time = ("2022-06-01 22:00").in_time_zone('Eastern Time (US & Canada)')
=> Wed, 01 Jun 2022 22:00:00.000000000 EDT -04:00

flight_time.in_time_zone('UTC')
=> Thu, 02 Jun 2022 02:00:00.000000000 UTC +00:00
```

## Solution
We need to take into account the departing airport's time zone when performing a flight search.

```
selected_date = ("2022-06-01").in_time_zone('Eastern Time (US & Canada)')
selected_date.all_day

=>
Wed, 01 Jun 2022 00:00:00.000000000 EDT -04:00
..
Wed, 01 Jun 2022 23:59:59.999999999 EDT -04:00
```

Now the search `Flight.where(departure_date: selected_date.all_day` will find any flight that departs on 6/1/2022 in the eastern time zone.  This is all well and good, however, this time is being converted by rails under the hood to utc to perform a search.

In the end, my preference is to explicitly convert the time range to UTC prior to searching for the added clarity.

```
selected_date = ("2022-06-01").in_time_zone('Eastern Time (US & Canada)')
selected_date = selected_date.in_time_zone('UTC').all_day
=>
Wed, 01 Jun 2022 00:00:00.000000000 UTC +00:00
..
Wed, 01 Jun 2022 23:59:59.999999999 UTC +00:00
```

There's still a minor problem here due to using `all_day`, which gives us a 00:00:00 to 23:59:59 time range in a specific time zone.  That's not really what we want when explicitly using UTC.  We want a time range in UTC that represents the start and end of a day in the local time zone.

```
selected_date = ("2022-06-01").in_time_zone('Eastern Time (US & Canada)')
selected_date.in_time_zone('UTC')..(selected_date.in_time_zone('UTC') + 1.days)

=>
Wed, 01 Jun 2022 04:00:00.000000000 UTC +00:00
..
Thu, 02 Jun 2022 04:00:00.000000000 UTC +00:00
```

Now our 6/1/2022 10:00 PM eastern time zone flight - or 6/2/2022 2:00 AM in UTC - falls into the search range.