local Weather = {}

Weather.list = {
    "sunny", 
    "cloudy", 
    "foggy", 
    "rain", 
    "thunderstorm", 
    "snow", 
    "heatwave", 
    "freezing",
}

Weather.season = {
    spring = { "sunny", "cloudy", "rain", "foggy", "thunderstorm"  },
    summer = { "sunny", "cloudy", "rain", "heatwave", "thunderstorm" },
    autumn = { "sunny", "cloudy", "rain", "foggy", "thunderstorm" },
    winter = { "cloudy", "snow", "freezing", "foggy" },
}

return Weather