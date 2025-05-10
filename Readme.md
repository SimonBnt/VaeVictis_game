<h1 style="padding-bottom : 1rem">💀 VaeVictis 💀</h1>
<h2 style="border-bottom: solid 1px">Dark fantasy Pixel art action roguelike rpg</h2>

VaeVictis is a project that’s been close to my heart for quite some time now. All the ideas and inspirations I’ve collected in my head are finally starting to take shape ever since I began developing the game using Lua and LÖVE2D.

If I had to categorize VaeVictis, I’d say it’s an action roguelike RPG set in a dark fantasy universe inspired by Berserk, Bloodborne, and Dark Souls, brought to life in pixel art.

For the game’s design, I draw inspiration from titles like Vampire Survivors, Risk of Rain, Bloodborne, Slay the Spire, Noita, and many others. I borrow small bits of gameplay and ideas that personally struck me, elements that might seem minor, but give that addictive “just one more run” feeling and make the gameplay truly fun.

One of my goals with VaeVictis is to create near-infinite replayability, allowing you to embark on ever more challenging and varied monster-hunting expeditions. While balancing a game is always a difficult task, I aim to make it as hardcore as possible. Your hero will grow stronger throughout each expedition—but the game will never go easy on you. The idea is that you get better, not that the game gets easier.

If you want to know more about VaeVictis and follow future updates, check out the todo.txt file right here in the repository. You can also follow me on social media (coming soon), the official VaeVictis website (coming soon), or the game’s pages on itch.io and Steam (coming soon), where I will regularly post devlogs.

-- (Coming soon) --

Don’t forget to wishlist and follow the project . It really helps spread the word and gives me valuable feedback to keep improving the game, and to craft an experience that’s always more fun, challenging, and rewarding.

A demo will also be available soon on Steam. Feel free to download it, give it a try, die a few times, and share your thoughts on the game!

<hr style="border: none; border-top: 0.25rem solid #ccc;">

📖 A little bit of scenario 📖

"You play as a wandering monster hunter, a lone mercenary roaming a world ravaged by the 'Miasma.' Every expedition is a fight for survival: track down nightmarish creatures, harvest their precious resources, and sell them to upgrade your gear and hone your combat skills.

But this cycle of hunting and trading comes at a cost. The farther you venture, the deadlier the monsters become. The world itself is a relentless enemy—the Miasma corrupts everything it touches, turning life into savage abominations eager to tear you apart.

Traverse these tainted lands with your sword, your shield, and your 'Mana Lamp,' powered by rare crystals that allow you to survive in the Miasma. But for how long? Remember to recharge it… or your fate is sealed. Or worse.

Kill, trade, survive… until death finally catches up to you."

<hr style="border: none; border-top: 1px solid #ccc;">

🦸‍♂️ Le Héro, enfin "Victis", mais c'est vous qui le controler, bref vous m'avez compris... 🦸‍♂️

<hr style="border: none; border-top: 0.5px solid #ccc;">

On ne sait pas grand chose sur "Victis" mise à part qu'il gagne sa vie en travaillant comme chasseur de monstre itinérant. Mais comme tout humain qui se respecte il a évidement des pv, du mana et une barre d'xp, cela va de sois.

Il porte un sac plus ou moins infini ou il pourra ranger avec précotion et rigueur tous les objets qu'il trouvera, tel un joueur de Tetris. Faites seulement attention au poids de votre inventaire, la place ce n'est pas un probleme mais le poids s'en est un, la physique ca existe vous savez.

Ah oui joubliais, Victis est enregistré dans la "guilde des chasseur", la fameuse, vous en avez deja surement entendu parlé. 
Chaque chasseur dispose d'un rang allant du E à S, ca me rappel quelque chose...
Bref en tout cas plus vous etes doué et plus vous grimperez dans les rangs. 
A quoi ca sert ? J'en sais trop rien.

👻 Bestiary 👻

<hr style="border: none; border-top: 0.5px solid #ccc;">

Pour l'instant je prévois 73 types de monstre dans lesquels vous pourrez retrouver des classics de rpg comme des rat, slime, chauve souris, squelette, orc et bien d'autres mais aussi certains un peu moins courant, comme des crapauds et des escargots mutants, ou encore des "créatures des marais"...

Tous sont classés par "classe de monstre", du rang S au rang E, S etant les plus rares, dangereux et redoutables et E les plus communs et les moins coriaces.

Chacun ont leur habitat de préférence et leurs heures d'apparitions, certains préfere les jours ensoleilé, d'autres les forets de nuit, certtains preferes ramper dans les marécages par temps de pluies. A vous de les traquer pour les vaincres et récuperer leur précieux composants.

Tous looteront des fragments de mana de plus ou moins grandes valeur suivant leur classe mais aussi des des composants en tous genre qui serviront de marchandise a vendre ou de composant pour améliorer vos équipements. Ils vous fourniront aussi dans certains cas des objest utiles comme des potions ou de quoi aiguiser votre arme.

Si vous etes chanceux vous trouverez un coffre sur certains d'entre eux, mais attention aux mimics !

<hr style="border: none; border-top: 1px solid #ccc;">

⚔️ Fight system ⚔️

<hr style="border: none; border-top: 0.5px solid #ccc;">

-"Set de techniques" 🐱‍👤

<hr style="border: none; border-top: 0.5px solid #ccc;">

System de "set de techniques" : vous commencez avec set d'attaque composé d'un "combo" de 3 coups, chacuns ont leur spécificités, leur timing pour executer l'attaque parfaitement mais surtout leur combinaison de touche pour les réaliser.

Autrement dit : lorsque que votre héro est pret à attaquer, maintenant la touche de "préparation d'attaque", enchainez ensuite les combinaision de touches correspondantes aux différentes techniques, appuyez avec le bon rythme et vous enchainerez les attaques jusqu'à un maximum de 7 à la suite, la 7eme etant dévastatrice.

Votre "set de technique" peut atteindre un maximum de 7 attaques différentes que vous apprendrez durant votre expedition. 
Votre set est modifiable durant les phases de repos. Ce qui peut avoir son importance en sachant que certaines techniques ont des synergies avec d'autres, par exemple si votre 4eme attaque est "Coup de grâce", et que votre ennemie est en train de "saigner" grace à l'attaque "estoc", alors les degats seront décuplé et le saignement intensifié. Ceci n'est qu'une sinergie parmis temps d'autres que je vous laisserais découvir par vous meme.

-Sort 🧙🏻‍♂️

<hr style="border: none; border-top: 0.5px solid #ccc;">

Des sorts de types élementaires seront aussi disponible pour completer votre arsenal de combat mais aussi des sorts de soutien, bouclier et soins par exemple.

-Objets 🛠
<hr style="border: none; border-top: 0.5px solid #ccc;">

Vous pourrez aussi utiliser toute une varitée d'objets "utilisable" pour vous aider dans vos expeditions et durant les combats.

-Parade et riposte 🛡

<hr style="border: none; border-top: 0.5px solid #ccc;">

Sachez seulement que vous etes humain et qu'il suffira de quelques attaques d'un Ogre pour vous tuer, faite donc bien attention de parer les attaques au bon moment pour vous éviter une mort certaine. Si vous réussissez votre parade, vous pourrez alors riposter avec une attaque, qui si elle est suivis de la bonne techqiues et dans le bon timing, qui permettra d'enchainer avec un combo sans a avoir a attendre que votre héro soit "pret a attaquer".

<hr style="border: none; border-top: 0.5px solid #ccc;">

Pour le reste, je vous laisse le soin de découvrir.

<hr style="border: none; border-top: 1px solid #ccc;">

🎯 Objetive, quest and bounty 🎯

<hr style="border: none; border-top: 0.5px solid #ccc;">

-Objectiv 🎯: 

<hr style="border: none; border-top: 0.5px solid #ccc;">

Survivre à votre expedition. Pourquoi etre "chasseur de monstre" alors que votre vie ne tient qu'a un fil meme face au plus "inofensif" des monstres ? 
C'est simple, c'est un metier comme un autre. 
Et puis c'est celui dans lequel vous etes le plus doué. 
Il suffit de ne pas mourrir écraser, déchiqueter, dévorer, carbonisé, vidé de son sang, démembrer ou encore dissous et tous se passera bien.

<hr style="border: none; border-top: 0.5px solid #ccc;">

-Quete 📰: 

<hr style="border: none; border-top: 0.5px solid #ccc;">

Durant vos expeditions, vous aurez peut etre la chance d'arriver jusqu'a un village dans lequel vous pourrez vous reposer, vendre, améliorer votre équipement mais surtout consulter le tableau de quetes qui vous permettra d'obtenir des récompenses en plus lors de votre prochain passage en ville, enfin si vous ne finissez pas dans le vendre d'un escargot goliath en chemin, cela va de soi.

Exemple de quete : 
    - "Le marché de l'immobilier s'effondre"
        Les clients meurent tous avant de signer le bail. 
            Tuer 3 gobelins
    - "Les colliers avec des dents de loups en résines c'est cool" 
        Mais les vrais c'est encore mieux !
            Apporter 3 crocs de loups
    - "Le druide du coin n'est pas très doué". 
        Depuis qu'il s'est installé dans le village, le taux de mortallité a augmenté. Tous ceci est bien étrange...
            Apporter deux potion de vie inférieurs

<hr style="border: none; border-top: 0.5px solid #ccc;">

-Bounty 💰: 

<hr style="border: none; border-top: 0.5px solid #ccc;">

Chaque village proposera au moins un contrat de chasse. 
Comprenez les villagois, c'est dure de se faire étriper à chaque cuiellette de champignon...Mais revenons à nos moutons.

Chaque cible est un monstre unique rencontrable uniquement via les contrats de chasse. 
Attraper les tous ! Euh non ca c'est un autre jeu...

Plus votre rang de chasseur sera élévé et plus les contrats seront mortelles et la récompense aussi !

⏳ Vae Victis est en cours de développement ⏳

<hr style="border: none; border-top: 0.5px solid #ccc;">

Je vais communiquer le plus possible sur les réseaux, le site officiel, la page Steam, Itch.io, Epic, publier des dev logs etc.

SOyez patients et à l'affue de nouvelles de ma part.

✨ Remerciement ✨

Merci de suivre le projet, whichlist et tutiquanti !

J'espere que vous pourrez vite partir en expedition, et massacrer le plus de monstre possible !