local Sound = {}

Sound.sword = {
    s1 = love.audio.newSource("assets/soundEffect/sword/1.wav", "stream"),
    s2 = love.audio.newSource("assets/soundEffect/sword/2.wav", "stream"),
    s3 = love.audio.newSource("assets/soundEffect/sword/3.wav", "stream"),
    s4 = love.audio.newSource("assets/soundEffect/sword/4.wav", "stream"),
    s5 = love.audio.newSource("assets/soundEffect/sword/5.wav", "stream"),
    s6 = love.audio.newSource("assets/soundEffect/sword/6.wav", "stream"),
    s7 = love.audio.newSource("assets/soundEffect/sword/7.wav", "stream"),
    s8 = love.audio.newSource("assets/soundEffect/sword/8.wav", "stream"),
    s9 = love.audio.newSource("assets/soundEffect/sword/9.wav", "stream"),
}

function Sound.trigger(name)
    if name == "sword" then
        local selectedSwordSound = math.random(1, 9)
        local key = "s" .. selectedSwordSound
        local src = Sound.sword[key]
        
        if src then
            src:stop()
            src:play()
        end
    end
end

return Sound
