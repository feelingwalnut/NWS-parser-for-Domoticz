this script is marginally functional at best for the moment.

domoticz settings, http/https poller
method get
content type application/json
url https://api.weather.gov/stations/----/observations/latest
(replace ---- with your station)
station is found on weather.gov, use the "Local forecast by "City, St" or ZIP code" on the top left to find your station.

on the resulting page near the top it will say
"Current conditions at"
your location (----)
for example below, new york city.

Current conditions at
New York City, Central Park (KNYC)

https://api.weather.gov/stations/KNYC/observations/latest
will result in a valid json page.
