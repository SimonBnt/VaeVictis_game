local Weather = require("modules.expedition.Weather")
local GameTime = require("modules.expedition.GameTime")

local Calendar = {}

Calendar.maxDay = 365
Calendar.day = 1
Calendar.days = {}

local function getSeason(day)
    if day >= 355 or day < 79 then
        return "winter"
    elseif day >= 79 and day < 172 then
        return "spring"
    elseif day >= 172 and day < 266 then
        return "summer"
    elseif day >= 266 and day < 355 then
        return "autumn"
    end
end

-- Liste des jours par mois (année non bissextile)
Calendar.months = {
    {name="Janvier", days=31},
    {name="Février", days=28},
    {name="Mars", days=31},
    {name="Avril", days=30},
    {name="Mai", days=31},
    {name="Juin", days=30},
    {name="Juillet", days=31},
    {name="Août", days=31},
    {name="Septembre", days=30},
    {name="Octobre", days=31},
    {name="Novembre", days=30},
    {name="Décembre", days=31},
}

-- Génère le mapping jour/mois/jourDuMois
function Calendar:generate()
    math.randomseed(os.time())
    local d = 1
    for mi, m in ipairs(self.months) do
        for dj = 1, m.days do
            local season = getSeason(d)
            local list = Weather.season[season]
            local weather = list[math.random(#list)]
            self.days[d] = { season = season, weather = weather, month=mi, dayOfMonth=dj }
            d = d + 1
        end
    end
end

-- Retourne la page (mois) demandée sous forme d'une liste d'objets {num, weather, ...}
function Calendar:getMonthPage(monthIndex)
    local m = self.months[monthIndex]
    if not m then return {} end
    local startDay = 1
    for mi = 1, monthIndex - 1 do
        startDay = startDay + self.months[mi].days
    end
    local days = {}
    for i = 0, m.days - 1 do
        local dayIndex = startDay + i
        days[#days+1] = self.days[dayIndex]
    end
    return days
end

function Calendar:getCurrentMonth()
    for mi, m in ipairs(self.months) do
        local startDay, endDay = 1, m.days
        for i = 1, mi-1 do startDay = startDay + self.months[i].days end
        endDay = startDay + m.days - 1
        if self.day >= startDay and self.day <= endDay then
            return mi, self.day - startDay + 1
        end
    end
    return 1, 1
end

function Calendar:getCurrentWeather()
    return self.days[self.day].weather
end

function Calendar:getViewDays(numDays)
    numDays = numDays or 4
    local res = {}
    local mid = math.floor(numDays / 2) + 1 -- le jour courant sera à cette place (ex : 3 sur 4 => 3e slot)
    for i = 1, numDays do
        local offset = i - mid
        local idx = self.day + offset
        if idx < 1 then idx = 1 end
        if idx > self.maxDay then idx = self.maxDay end
        res[i] = {weather = self.days[idx].weather, day = idx}
    end
    return res
end

function Calendar:getDayProgress()
    return GameTime.minutes / 1440
end

function Calendar:update(isNewDay)
    if isNewDay then
        self.day = self.day + 1
        if self.day > self.maxDay then
            self.day = 1
        end
    end
end

Calendar:generate()

return Calendar