<h1 style="border : none">💀 VaeVictis 💀</h1>
<h2 style="border-bottom: solid 1px">🗡Dark fantasy Pixel art action roguelike rpg</h2>

VaeVictis is a project that’s been close to my heart for quite some time now. All the ideas and inspirations I’ve collected in my head are finally starting to take shape ever since I began developing the game using Lua and LÖVE2D.

If I had to categorize VaeVictis, I’d say it’s an action roguelike RPG set in a dark fantasy universe inspired by Berserk, Bloodborne, and Dark Souls, brought to life in pixel art.

For the game’s design and gameplay, I draw inspiration from titles like Vampire Survivors, Risk of Rain, Bloodborne, Slay the Spire, Noita, and many others. I borrow small bits of gameplay and ideas that personally struck me, elements that might seem minor, but give that addictive “just one more run” feeling and make the gameplay truly fun.

One of my goals with VaeVictis is to create near-infinite replayability, allowing you to embark on ever more challenging and varied monster-hunting expeditions. While balancing a game is always a difficult task, I aim to make it as hardcore as possible. Your hero will grow stronger throughout each expedition—but the game will never go easy on you. The idea is that you get better, not that the game gets easier.

If you want to know more about VaeVictis and follow future updates, check out the todo.txt file right here in the repository. You can also follow me on social media (coming soon), the official VaeVictis website (coming soon), or the game’s pages on itch.io and Steam (coming soon), where I will regularly post devlogs.

-- (Coming soon) --

Don’t forget to wishlist and follow the project . It really helps spread the word and gives me valuable feedback to keep improving the game, and to craft an experience that’s always more fun, challenging, and rewarding.

A demo will also be available soon on Steam, Itch.io and Epic Store. Feel free to download it, give it a try, die a few times, and share your thoughts on the game!

<h2 style="border-bottom: solid 1px">📖 A little bit of scenario 📖</h2>

"You play as a wandering monster hunter, a lone mercenary roaming a world ravaged by the 'Miasma.' Every expedition is a fight for survival: track down nightmarish creatures, harvest their precious resources, and sell them to upgrade your gear and hone your combat skills.

But this cycle of hunting and trading comes at a cost. The farther you venture, the deadlier the monsters become. The world itself is a relentless enemy—the Miasma corrupts everything it touches, turning life into savage abominations eager to tear you apart.

Traverse these tainted lands with your sword, your shield, and your 'Mana Lantern,' powered by rare crystals that allow you to survive in the Miasma. But for how long? Remember to recharge it… or your fate is sealed. Or worse.

Kill, trade, survive… until death finally catches up to you."

<h2 style="border-bottom: solid 1px">🦸‍♂️ The Hero… well, “Victis” — but you're the one in control, you get the idea. 🦸‍♂️</h2>

Not much is known about Victis, other than that he makes a living as a wandering monster hunter. 

Like any respectable human, of course, he has HP, mana, and an XP bar — naturally.

He carries a more or less infinite bag where he carefully organizes everything he finds, like a master of Tetris. But be warned: while space isn’t a problem, weight is. Physics is a thing, you know.

Strangely, despite this rigor, he can't help but hang the trinkets he finds on his bag, it's not very aesthetic...

Oh, and I almost forgot: Victis is a registered member of the famous Hunter’s Guild — you’ve probably heard of it. 

Every hunter is ranked from E to S (reminds me of something…). The better you are, the higher you climb. What’s the point? …Honestly, I’m not entirely sure.

<h2 style="border-bottom: solid 1px">👻 Bestiary 👻</h2>

At the moment, I’m planning 73 different monster types. You’ll find classic RPG enemies like rats, slimes, bats, skeletons, orcs, and many more — but also some more unusual creatures like mutant toads, giant snails, and eerie swamp creatures.

All monsters are categorized by “Monster Rank” from E to S — with S being the rarest, most dangerous and fearsome, and E the most common and least threatening.

Each monster has its preferred habitat and active time: some love sunny days, others lurk in dark forests at night, while some crawl through rainy swamps. It’s up to you to track them down, defeat them, and harvest their precious materials.

Every monster drops mana fragments (with value depending on their rank, use it to reload your lantern), along with various components you can either sell or use to upgrade your equipment. Sometimes they’ll also drop useful items like potions or whetstones for sharpening your weapon.

If you’re lucky, you might even find a chest on a defeated monster… but beware of mimics!

<h2 style="border-bottom: solid 1px">⚔️ Fight system ⚔️</h2>

<h3>🐱‍👤 Technique Set</h3>

You’ll have a “technique set” system: you start with an attack combo of 3 moves, each with its own properties, execution timing, and button combination.

Here’s how it works:
When your hero is ready to attack, hold down the “attack prep” button, then input the correct key combinations for your different techniques. Press them in rhythm, and you’ll chain attacks together — up to 7 consecutive moves, with the 7th being devastating.

You can unlock up to 7 techniques for your set during your expedition. You’ll be able to edit your set at campfires or resting spots — crucial, since some techniques have synergies. 
For example, if your 4th move is “Finishing Blow”, and your target is already bleeding from a previous “Piercing Thrust”, the damage will be multiplied and the bleeding intensified.

That’s just one synergy among many… I’ll let you discover the rest for yourself!

<h3>🧙🏻‍♂️ Spells</h3>

You’ll also have access to elemental spells to enhance your combat options, plus support, shield, and healing spells.

<h3>🛠 Items</h3>

You can use various consumable items to aid you on your expeditions and in battle.

<h3>🛡 Parry & Riposte</h3>

Remember: you’re human. It only takes a few hits from an Ogre to end you. Time your parries carefully to avoid a quick death.
If you successfully parry, you’ll be able to riposte with an attack — and if you follow it up with the right technique at the right moment, you can instantly chain into a combo without waiting for your hero to be “ready to attack.”

I’ll let you discover the rest on your own.

<h2 style="border-bottom: solid 1px">🎯 Objectives, Quests & Bounties 🎯</h2>

<h3>🎯 Objective: </h3>

Survive your expedition.
Why be a monster hunter when your life hangs by a thread, even against the “weakest” enemies? Simple — it’s a job like any other. Besides, it’s what you’re best at.
Just… try not to get crushed, shredded, devoured, burned, drained, dismembered, or dissolved. You’ll be fine.

<h3>📰 Quests:</h3>

During your expedition, you might stumble across a village where you can rest, sell loot, upgrade your gear, and check the quest board for extra rewards on your next visit (assuming you don’t end up inside a giant snail by then).

Here are some example quests:

    The housing market is collapsing!
    “Heavens! All the clients keep vanishing before signing their lease…”
    → Kill 3 goblins

    Wolf fang necklaces in resin are cool…
    “…but real ones are even better!”
    → Bring 3 wolf fangs

    The local druid’s a bit… off.
    “Ever since he moved in, the village mortality rate has skyrocketed. Something’s definitely wrong…”
    → Bring 2 minor healing potions

<h3>💰 Bounties:</h3>

Each village offers at least one hunting contract.
Can you blame the villagers? It’s tough getting disemboweled every time you forage for mushrooms…

Each bounty target is a unique monster only available through contracts.
Catch ‘em all! …Wait, no, wrong game.

The higher your hunter rank, the deadlier the contracts — and the greater the rewards.

<h2 style="border-bottom: solid 1px">⏳ VaeVictis is currently in development!  ⏳</h2>


I’ll be sharing updates on social media, the official website, Steam page, Itch.io, Epic Games Store, devlogs, and more.

Stay tuned and keep an eye out for news!

<h2 style="border-bottom: solid 1px">✨ Thank You! ✨</h2>

Thanks for following the project, wishlisting, and all that good stuff!
I hope you’ll soon embark on your expedition… and slay as many monsters as possible!