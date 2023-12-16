-- Define device IDs
local wind_id =
local bar_id =
local rain_id =

-- Retrieve the content
s = request['content'];

-- Access JSON data and handle missing values
local WB = domoticz_applyJsonPath(s,'.properties.windDirection.value')

-- Given a wind direction in degrees, convert it into a compass direction value
-- For example, 0 degrees corresponds to 'N' (North), 90 degrees corresponds to 'E' (East), and so on
-- Function to convert degrees to compass direction
function degreesToCompassDirection(degrees)
    local val = math.floor((WB / 22.5) + 0.5)
    local compassArray = {'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW'}
    return compassArray[(val % 16)]
end
local WD = degreesToCompassDirection(degrees)

local WS = domoticz_applyJsonPath(s,'.properties.windSpeed.value')
local WG = domoticz_applyJsonPath(s,'.properties.windGust.value')
local TP = domoticz_applyJsonPath(s,'.properties.temperature.value')
local WC = domoticz_applyJsonPath(s,'.properties.windChill.value')
local BAR = domoticz_applyJsonPath(s,'.properties.barometricPressure.value')
local BAR_FOR = domoticz_applyJsonPath(s,'.properties.textDescription')
local RAINRATE = domoticz_applyJsonPath(s,'.properties.precipitationLastHour.value')
local RAINCOUNTER = domoticz_applyJsonPath(s,'.properties.precipitationLast6Hours.value')

-- Check and replace 'null' values with 0
if WS == null then WS = 0 end
if WG == null then WG = 0 end
if TP == null then TP = 0 end
if WC == null then WC = 0 end
if RAINRATE == null then RAINRATE = 0 end
if RAINCOUNTER == null then RAINCOUNTER = 0 end

-- Check if BAR is not null and greater than four digits long
if BAR ~= null and string.len(tostring(BAR)) > 4 then
  -- Truncate the value to four digits
  BAR = string.sub(tostring(BAR), 1, 4)
end
-- If BAR is still null, set it to 0
if BAR == null then
  BAR = 0
end

-- Update the devices in domoticz
domoticz_updateDevice(wind_id,'',WB .. ";" .. WD .. ";" .. WS .. ";" .. WG .. ";" .. TP .. ";" .. WC)
--domoticz_updateDevice(wind_id,'',WB .. ";" .. WS .. ";" .. WG .. ";" .. TP .. ";" .. WC)
domoticz_updateDevice(bar_id,'',BAR .. ";" .. BAR_FOR)
domoticz_updateDevice(rain_id,'',RAINRATE .. ";" .. (RAINCOUNTER * 4))
