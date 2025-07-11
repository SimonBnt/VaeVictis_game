local LoadingScreen = {}

LoadingScreen.tips = {
    "Astuce : Appuyez sur I pour ouvrir l’inventaire !",
    "Astuce : Utilisez les potions en cas de besoin.",
    "Astuce : Chaque monstre a une faiblesse différente.",
}

-- LoadingScreen.image = love.graphics.newImage("assets/ui/loading.png")

LoadingScreen.active = false
LoadingScreen.tip = ""
LoadingScreen.onLoaded = nil
LoadingScreen.progress = 0

function LoadingScreen:start(loadingFunction, onLoaded)
    self.active = true
    self.tip = self.tips[math.random(#self.tips)]
    self.onLoaded = onLoaded
    self.progress = 0

    -- Simule un chargement asynchrone
    self.loadingCoroutine = coroutine.create(function()
        loadingFunction(function(progress)
            self.progress = progress or 0
        end)
        self.active = false
        if self.onLoaded then self.onLoaded() end
    end)
end

function LoadingScreen:update(dt)
    if self.active and self.loadingCoroutine then
        coroutine.resume(self.loadingCoroutine)
    end
end

function LoadingScreen:draw()
    if self.active then
        love.graphics.setColor(0.08,0.08,0.08, 1)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1,1,1,1)
        -- image/animation
        -- love.graphics.draw(self.image, 320, 140, 0, 1, 1, self.image:getWidth()/2, self.image:getHeight()/2)
        -- astuce
        love.graphics.setFont(love.graphics.newFont(16))
        love.graphics.printf(self.tip, 0, 240, 640, "center")
        -- barre de chargement
        love.graphics.rectangle("line", 220, 280, 200, 12)
        love.graphics.rectangle("fill", 220, 280, 200 * self.progress, 12)
    end
end

return LoadingScreen