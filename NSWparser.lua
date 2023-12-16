-- Define device IDs
local wind_id =
local bar_id =
local rain_id =

-- Retrieve the content
s = request['content'];

-- Access JSON data and handle missing values
local WB = domoticz_applyJsonPath(s,'.properties.windDirection.value')
--local WD =
local WS = domoticz_applyJsonPath(s,'.properties.windSpeed.value')
local WG = domoticz_applyJsonPath(s,'.properties.windGust.value')
local TP = domoticz_applyJsonPath(s,'.properties.temperature.value')
local WC = domoticz_applyJsonPath(s,'.properties.windChill.value')
local BAR = domoticz_applyJsonPath(s,'.properties.barometricPressure.value')
local BAR_FOR = domoticz_applyJsonPath(s,'.properties.textDescription')
local RAINRATE = domoticz_applyJsonPath(s,'.properties.precipitationLastHour.value')
local RAINCOUNTER = domoticz_applyJsonPath(s,'.properties.precipitationLast6Hours.value')

-- Removing the last two digits if barometric pressure value returns six digits
--if string.len(BAR) == 6 then BAR = string.sub(BAR, 1, 4) end

-- Converting wind direction from degrees to a compass degree designation
--local compassDirections = {"N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"}
--local index = math.floor((WD / 22.5) + 0.5) % 16
--local compassDegree = compassDirections[index + 1]

-- Check and replace 'null' values with 0
if WS == null then WS = 0 end
if WG == null then WG = 0 end
if TP == null then TP = 0 end
if WC == null then WC = 0 end
if BAR == null then BAR = 0 end
if RAINRATE == null then RAINRATE = 0 end
if RAINCOUNTER == null then RAINCOUNTER = 0 end

-- Update the devices in domoticz
--domoticz_updateDevice(wind_id,'',WB .. ";" .. WD .. ";" .. WS .. ";" .. WG .. ";" .. TP .. ";" .. WC)
domoticz_updateDevice(wind_id,'',WB .. ";" .. WS .. ";" .. WG .. ";" .. TP .. ";" .. WC)
domoticz_updateDevice(bar_id,'',BAR .. ";" .. BAR_FOR)
domoticz_updateDevice(rain_id,'',RAINRATE .. ";" .. RAINCOUNTER)
