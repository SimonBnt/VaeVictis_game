local Quest = {}

Quest.list = {
    main = {
        { name = "Become a monster hunter !", description = "Kill a skeleton, a slime, a giant rat and a gobelin.", condition = {
            {
                name = "Skeleton : ",
                currentState = 0,
                conditionToFinish = 1,
            },
            {
                name = "Slime : ",
                currentState = 0,
                conditionToFinish = 1,
            },
            {
                name = "Giant rat : ",
                currentState = 0,
                conditionToFinish = 1,
            },
            {
                name = "Gobelin : ",
                currentState = 0,
                conditionToFinish = 1,
            },
        }, isFinished = false },
        { name = "main quest 2", description = "main quest description 2", currentState = 0, condition = 10, isFinished = false },
        { name = "main quest 3", description = "main quest description 3", currentState = 0, condition = 10, isFinished = false },
    },
    hunt = {
        f = {
            { name = "Get rid of the gobelins!", description = "Kill 10 gobelins.", currentState = 0, condition = 10, isFinished = false },
            { name = "Rat on the menu.", description = "Bring 4 rat meats.", currentState = 0, condition = 4, isFinished = false },
            { name = "First steps as a hunter.", description = "Survive 3 days.", currentState = 0, condition = 3, isFinished = false },
        },
        e = {
            { name = "rank e hunt quest1", description = "rank e hunt quest description1", currentState = 0, condition = 10, isFinished = false },
            { name = "rank e hunt quest1", description = "rank e hunt quest description1", currentState = 0, condition = 10, isFinished = false },
            { name = "rank e hunt quest1", description = "rank e hunt quest description1", currentState = 0, condition = 10, isFinished = false },
        },
        d = {
            { name = "rank d hunt quest1", description = "rank d hunt quest description1", currentState = 0, condition = 10, isFinished = false },
            { name = "rank d hunt quest2", description = "rank d hunt quest description2", currentState = 0, condition = 10, isFinished = false },
            { name = "rank d hunt quest3", description = "rank d hunt quest description3", currentState = 0, condition = 10, isFinished = false },
        },
    },
    guild = {
        { name = "Guild quest1", description = "Guild quest description 1", currentState = 0, condition = 10, isFinished = false },
        { name = "Guild quest2", description = "Guild quest description 2", currentState = 0, condition = 10, isFinished = false },
        { name = "Guild quest3", description = "Guild quest description 3", currentState = 0, condition = 10, isFinished = false },
    },
    side = {
        { name = "side quest 1", description = "side quest description 1", currentState = 0, condition = 10, isFinished = false },
        { name = "side quest 2", description = "side quest description 2", currentState = 0, condition = 10, isFinished = false },
        { name = "side quest 3", description = "side quest description 3", currentState = 0, condition = 10, isFinished = false },
    },
}

-- ajouter une list pour chaque categorie : Quest.activeMain/Quest.activeHunt etc.

Quest.active = {
}

function Quest.putQuestInActiveList(category, subcategory, index)
    -- Exemples d'appels :
    -- Quest.putQuestInActiveList("main", nil, 1)
    -- Quest.putQuestInActiveList("hunt", "f", 2)
    -- Quest.putQuestInActiveList("guild", nil, 1)

    if category == "hunt" and subcategory then
        table.insert(Quest.active, Quest.list[category][subcategory][index])
    else
        table.insert(Quest.active, Quest.list[category][index])
    end
end

function Quest.getActiveQuest()
    return Quest.active
end

function Quest.draw()
    local px, py = 100, 100
    local w = 400
    local line_height = 24
    local padding = 10
    local currentY = py + padding

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", px, py, w, 600, 4)

    -- Section Main Quest
    love.graphics.print("Main quest", px + padding, currentY)
    currentY = currentY + line_height

    for _, quest in ipairs(Quest.active) do
        if quest and quest.name and quest.name ~= "" then
            love.graphics.print(quest.name, px + padding*2, currentY)
            currentY = currentY + line_height
            love.graphics.print(quest.description, px + padding*2, currentY)
            currentY = currentY + line_height

            -- Affichage de la/les condition(s)
            if type(quest.condition) == "table" then
                for _, cond in ipairs(quest.condition) do
                    local text = string.format("%s %d/%d", cond.name, cond.currentState, cond.conditionToFinish)
                    love.graphics.print(text, px + padding*3, currentY)
                    currentY = currentY + line_height
                end
            else
                local text = string.format("%d/%d", quest.currentState or 0, quest.condition or 0)
                love.graphics.print("Progress: " .. text, px + padding*3, currentY)
                currentY = currentY + line_height
            end

            love.graphics.print("Finished: " .. tostring(quest.isFinished), px + padding*3, currentY)
            currentY = currentY + line_height * 1.5
        end
    end

    -- changer en faissant le tri de chaque catégorie pour plus de clarté et logique de code, les quetes principales auront toujours au moins 2 conditions
    -- créer des onglets/pages pour les catégories de quetes
    -- ajouter animation de tournage de pages pour plus de profondeur
    -- comprendre comment faire/utiliser un systeme de vérification de l'état des conditions => dans update peut etre ?
    --  ajouter un systeme de "panneau de quete" pour selectionner certaines et les mettres dans les list active pour tester
    -- ajouter un systeme de sauvegarde pour tester la fonctionnalité de sauvegarde qui servira de squellete pour le module final "Save.lua" et comprendre comment ca marche.
end

return Quest