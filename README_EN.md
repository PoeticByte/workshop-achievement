![Image text](https://github.com/lingyunjinzhu/workshop-achievement/blob/master/preview.jpg)

# workshop-achievement | New Achievement (Reburn)

> 中文说明见 [README.md](README.md)

> Don't Starve Together Achievement Mod
> Steam Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=2139402585

An achievement mod for Don't Starve Together. It extends the playtime of a single save and gives you things to do in the late game, lets you experience a mix of abilities from many characters on a single character, and includes plenty of hidden achievements.

**New Achievement (Reburn)** layers a universal achievement, ability and leveling system on top of the base survival gameplay: complete achievements to earn points, then spend them to unlock abilities or raise your character's stats — giving you lasting goals and varied build paths beyond mere survival.

> This mod must be installed by the server and all clients.

---

## 1. Core Gameplay Loop

```
 Survive / Fight / Explore
        │
        ├─ Complete achievements ──► Achievement Points ──► Unlock & upgrade [Abilities]
        │                                                 └► Raise [Stats] (Health / Sanity / Hunger)
        │
        ├─ Kill creatures ──► Kill Value ──► Instantly complete an unfinished achievement (optional)
        │
        └─ Eat / Kill ──► EXP ──► Level up ──► Gain points, stat points, and a higher title
```

The whole system revolves around four resources: Achievement Points, Kill Value, EXP (Level) and Stat Points. Each is described below.

---

## 2. The Four Core Resources

| Resource | How to earn | Main use |
| --- | --- | --- |
| **Achievement Points** | Complete achievements; each grants 1–10 points | Unlock & upgrade **abilities**; raise **stats** |
| **Kill Value** | Kill creatures; counted by the target's max health tier | Spend a fixed amount to **instantly complete** an unfinished achievement (can be toggled in config) |
| **EXP / Level** | Eat food, kill creatures | Leveling up auto-grants achievement points and stat points, and raises your title |
| **Stat Points** | Gained on each level up; amount configurable (default 1) | Raise **Health / Sanity / Hunger** maximums |

### Kill Value table (by target's max health)
| Target max health | Kill Value | Note |
| --- | --- | --- |
| ≤250 | +1 | 33% chance to count |
| 250–800 | +3 | |
| 800–1250 | +5 | |
| 1250–2500 | +8 | |
| 2500–3500 | +21 | |
| 3500–5000 | +34 | |
| 5000–8000 | +55 | |
| 8000–18000 | +89 | |
| 18000–30000 | +144 | |
| 30000–55000 | +233 | |
| >55000 | +377 | |

> Vegetables, structures, walls, balloons and ground spikes do not count toward Kill Value.
> With "Spend Kill Value to complete achievements" enabled, once you reach the set amount (default 1000, configurable 500–5000) you may pick an unfinished achievement and complete it directly, awarding its points as usual.

### EXP & Leveling
- **Eating**: grants EXP by food tier — ordinary cooked dishes give about 100, while high-end recipes and rare foods give more.
- **Killing**: grants EXP by max health — 99–450 HP gives 30, 450–900 gives 30, 900–2400 gives 300, above 2400 gives 3000, otherwise 10.
- Kills have a chance to drop an **EXP Bean**, which can be picked up and eaten for extra EXP; the stronger the target, the higher the drop chance (about 2%, 9%, 23%, 76.5%).
- **EXP required per level**: the first level needs about 1000, increasing by 100 for each subsequent level, with no cap.
- On each level up: you automatically gain 1 achievement point (via the "Character Level Up" ability) and the configured number of stat points, with an effect and a title promotion.

---

## 3. Achievement System

### Scale & categories
The mod includes 250+ achievements across ten categories:

| Category | Meaning | Example |
| --- | --- | --- |
| All | Summary & ultimate goals | Complete every achievement |
| Kill | Kill a given creature a number of times | Kill 100 spiders, 200 hounds |
| Bestiary | Kill bosses or rare creatures | Dragonfly, Bearger, Klaus, Ancient Guardians, etc. |
| Food | Eat a given dish a number of times | Eat 200 foods, 80 Bacon and Eggs |
| Craft | Make a given item or structure | Make 80 Gunpowder, 33 Ruins Hats |
| Collect | Gather or pick a given item | Pick 1000 times, harvest 88 cacti |
| Time | Accumulate time in a given state | Survive at zero sanity, in cold/heat, walking/standing |
| Labor | Chopping, mining, hammering, etc. | Chop 500 trees, break 60 boulders |
| Death | Die in a specific way | Crushed by rock, struck by lightning, starvation, poison mushroom |
| Other | Miscellaneous & hidden | Krampus Sack, use a Life Giving Amulet, recruit small animals |

### How they're triggered
Achievements are judged automatically by action type, covering: killing, eating, dying, cooking, crafting items or structures, picking, labor, planting/deploying, recruiting followers, giving items to specific targets, total ingredients consumed, and sustaining a state for a set duration (such as holding or wearing a given item, riding, or having empty equipment slots).

### Mechanics
- **Difficulty multiplier**: required amounts are multiplied by the "Achievement Difficulty" config (0.5 / 1 / 1.5 / 2).
- **Valid kill check**: when killing a large creature, all players who are within range during its final moments and have dealt damage to it count as valid killers — shared across players, encouraging teamwork.
- **On completion**: a server-wide announcement, an effect above your head, and the awarded points; a few achievements grant a physical reward (e.g. "Gourmet" awards a Gift Wrap blueprint).
- **Character adaptation**:
  - Some characters skip achievements that don't apply (e.g. Wormwood doesn't count "poison mushroom death", Wanda skips "crushed / starvation / lightning", Wurt skips many meat-dish food achievements).
  - Some characters get exclusive achievements (Winona, Willow, Wickerbottom, Wigfrid, Warly and WX-78 each have one or two exclusive crafting achievements).

### Hidden Achievements
The following achievements do not show their conditions in the list and are completed automatically once specific conditions are met in-game. Some conditions are demanding or are easter eggs, and can be treated as extra long-term challenges.

| Name | Condition | Points |
| --- | --- | --- |
| Lucky Emperor | Kill Krampus and make it drop a Krampus Sack | 10 |
| True Luck (timed) | Achieve "Lucky Emperor" before the end of day 22 | 5 |
| One General's Success | Die 50 times in total | 5 |
| World of Gluttony | Eat 2000 foods in total | 3 |
| Surviving in the World | Survive more than 666 days | 4 |
| Production Machine | Craft more than 3000 times in total | 4 |
| Life of Killing | Deal more than 1,000,000 total damage | 4 |
| Taking Ten Thousand Damage | Take more than 10,000 total damage | 4 |
| Truly Unfortunate | Die to a Moleworm or a Rabbit | 1 |
| Junior Chef | Cook 1000 foods in total | 1 |
| Craving Dragon Fruit | Kill 3 Saladmanders (Fruit Dragons) | 1 |
| The Author's Holy Light Surrounds You | Type "祈福" (a blessing) in chat | 1 |

> **Boss kill tally**: a separate hidden reward — when your cumulative kills of certain bosses reach milestones such as 3, 5 or 8, a "Killed [Boss] N times" message triggers and grants 1 extra achievement point each time.
> The amounts above are likewise affected by the "Achievement Difficulty" config.

---

## 4. Ability System

You learn abilities with **Achievement Points** in the main interface. Abilities fall into four groups: stat boosts, survival & gathering perks, character skill ports, and environmental & allegiance buffs.
Abilities marked "(toggleable)" can be turned on or off at will after learning; stat-boost abilities can be learned multiple times to stack, with the stack cap configurable.

> "Cost" below is the base point cost, which is multiplied by the "Ability Cost" config (0.5 / 1 / 1.5 / 2).

### Stat boosts (stackable, with a learn-count cap)
| Ability | Cost | Effect | Cap (configurable) |
| --- | --- | --- | --- |
| Damage Up | 10 | +5% attack power per level | Default 5 |
| Speed Up | 15 | +5% movement speed per level | Default 5 |
| Defense Up | 15 | +5% damage absorption per level | Default 5 |
| Critical Reward | 20 | Chance to deal double damage | Default 20 |

### Combat, survival & gathering perks
| Ability | Cost | Effect |
| --- | --- | --- |
| Thorns (toggleable) | 40 | Reflect part of incoming damage; higher reflection against bosses |
| Electric Shock (toggleable) | 88 | Melee attacks deal extra electric damage, with an orbiting arc effect |
| Freeze Ability (toggleable) | 50 | Chance to freeze targets on hit; always freezes attackers when you are hit |
| Bloodthirsty | 25 | Heal a little health and sanity on hit; also craft Wigfrid's weapons, helms and potions |
| Firm Armor | 25 | Wearing thulecite armor grants +100 armor durability |
| Double Drop | 80 | Enemies drop double loot when killed |
| Fishing Master | 40 | Fish bite almost instantly while fishing |
| Chopping Master | 40 | Fell an entire tree in a single swing |
| Gold Miner | 30 | Break rocks and mineable nodes in a single hit |
| Double Gather | 40 | Double yield when picking and harvesting |
| Fast Collection | 35 | Greatly speed up gathering and harvesting |
| Master Chef (toggleable) | 40 | Cook faster and gain Warly's chef-related abilities |
| Material Saver | 88 | Crafting items costs half the materials |
| Fresh Carrier | 60 | Items in your inventory slowly regain freshness, delaying spoilage |
| Auto Repair | 40 | Equipped ordinary items slowly repair their own durability |
| Magic Repair | 30 | Equipped magical items slowly repair their own durability |
| Leader Tag | 50 | Wearing the Bee Queen Crown makes bees, pigs, bunnymen, spiders and hounds follow you |

### Character skill ports
Turns each official character's signature abilities (including parts of their official skill tree) into unlockable abilities. Learning a skill-tree ability grants the representative skills from that character's tree and unlocks the matching recipes.

| Ability | Cost | Source & effect |
| --- | --- | --- |
| Engineering Tech | 70 | Winona: fast building + full skill tree (catapults, batteries, spotlights and all upgrades, portable structures, remote, teleport, shadow & lunar charging) |
| Fearless | 50 | Walter: tent, slingshot & Woby + skill tree (slingshot mods, many special ammo types, Woby upgrades, camping perks) |
| Fire Immunity | 40 | Willow: fire immunity, sanity near fire, craft a lighter & Bernie + skill tree (fire upgrades, fireballs, Bernie boosts) |
| Master of the Flame | 15 | Wilson: torches last longer and burn brighter, and can be thrown |
| Plant Friend (toggleable) | 40 | Wormwood: plant seeds by hand, regain sanity, craft living logs & bramble + crafting tree (saplings, berry bushes, reeds, lureplant, syrup, mushroom planter upgrades, plant identification & quick-pick) |
| Soul Hop | 55 | Wortox: kills drop souls, soul-hop teleport + skill tree (soul shields, healing boosts, lifted spirits, thieving, soul decoys, soul jars & nab bags) |
| Ghostly Friend | 70 | Wendy: summon ghost Abigail + skill tree (Abigail forms & command upgrades, sisturn, elixirs, ghost flowers, gravestones) |
| War God's Arsenal | 40 | Wigfrid: craft the Elding Spear, Commander's Helm and Battle Rönd with all upgrades, gain planar defense and a protective beefalo saddle (battle songs / inspiration branch not included, as they need a dedicated system) |
| Human Woodie | 50 | Woodie: craft three totems; eating each grants fast chopping, bonus damage or damage reduction |
| Well Dressed | 50 | Maxwell: craft the shadow codex to summon shadow minions that fight and work |
| Book Reader | 75 | Wickerbottom: craft and read all books (including the old horticulture tome) |
| Justice Rain | 20 | Wickerbottom: additionally unlock the Meteor and Petrify-Trees exclusive books |
| Time Manager | 88 | Wanda: gain watches and rewind/teleport time abilities |
| Alchemy Tech | 35 | Wilson: unlock transmutation recipes |

### Environmental, allegiance & other buffs
| Ability | Cost | Effect |
| --- | --- | --- |
| Firefly Light (toggleable) | 50 | Constantly emit a small radius of light, letting you see in the dark |
| Moisture Immunity (toggleable) | 25 | Immune to wetness; never get wet in the rain |
| Season Adapt | 50 | No cold in spring/winter, no heat in summer/autumn |
| Ignore Storm | — | Walk freely through summer sandstorms |
| Strong Stomach | 25 | Eat anything with no penalty; monster meat drains hunger slower |
| Shadow Submissive (toggleable) | 45 | Shadow creatures stop attacking you; skeletons follow you |
| Lunar Aligned | 40 | Lunar allegiance: 20% less damage from lunar foes, 20% more damage to shadow foes |
| Shadow Aligned | 40 | Shadow allegiance: 20% less damage from shadow foes, 20% more damage to lunar foes |
| Moon Blessing | 20 | Build moon platforms |
| Ancient Tech | 20 | Build an ancient pseudoscience station to unlock ancient tech on the spot |
| Event Tech | 30 | Unlock tech and craftables from the various seasonal events |
| Murloc Disguise (toggleable) | 45 | Build merm houses, marsh turf and carpet (move faster on carpet) |
| Flashy (toggleable) | 20 | Leave flashy effects while moving or standing still, with a halo at your feet |
| Supply Construction | 50 | Build precise supply items and antler decorations |
| Character Level Up (toggleable) | 0 | On by default: gain achievement points when your character levels up |

> If you already play the character an ability comes from (e.g. learning "Engineering Tech" as Winona, or "Soul Hop" as Wortox), the system skips the duplicate grant to avoid conflicts.

---

## 5. Stat System

Spend **Stat Points** to raise each of your three maximums directly, +1 per point:

| Stat | Raises | Cost |
| --- | --- | --- |
| Health | Max health | 1 point per +1 |
| Sanity | Max sanity | 1 point per +1 |
| Hunger | Max hunger | 1 point per +1 |

- Stat points are mainly gained by leveling up; the amount per level is configurable (1–10).
- You can "Reset Stats" in the interface, refunding stat points by the configured ratio (default 90%, configurable 50%–100%).
- The entire stat system can be disabled in the config.

---

## 6. Reset Mechanics

| Item | Description |
| --- | --- |
| Reset abilities | Refund learned abilities and return achievement points by the configured ratio (default 90%, configurable 50%–100%) |
| Reset stats | Refund added stats and return stat points by the configured ratio (default 90%) |
| Lossless reset count | Every set number of survived days (default 100, configurable 50–600) grants one lossless reset; ability resets and stat resets share this count, refunding in full when used |

---

## 7. Auxiliary Systems & Config

### Starting gifts (can be disabled)
About three seconds after entering the game you receive:
- A Battle Spear and Battle Helm (given when not playing Wigfrid)
- Large Halloween Health Potion ×2
- One Red Lantern and one Pumpkin Lantern

### Boss strengthening (optional, off by default)
When enabled, some bosses gain strengthened, more threatening behavior. For example, the Dragonfly knocks off the player's equipment on hit or when struck, and summons rings of fire and bramble traps around itself (always triggered when multiple players are present). This option is aimed at players seeking harder fights.

### Interface & controls
- The main interface has three tabs — Achievements, Abilities and Level — and can be enlarged or shrunk.
- Press N to show or hide the main interface (configurable).
- A title above your head is promoted with your level and progress, across eleven tiers:
  On the Brink → Walking on Thin Ice → Barely Passable → Getting the Hang of It → Practice Makes Perfect → Handy → More Than Capable → Fully Prepared → Effortless → As You Please → Whatever You Want.
  Title display can be toggled in the config.

### Config options
| Option | Default | Description |
| --- | --- | --- |
| Can learn abilities | Yes | If off, you only complete achievements without unlocking abilities |
| Give starting gifts | Yes | See "Starting gifts" |
| Boss strengthening | No | See "Boss strengthening" |
| Ability reset refund | 90% | 50%–100% |
| Stat reset refund | 90% | 50%–100% |
| Show title | Show | |
| Language | Simplified Chinese | Simplified Chinese / English |
| Achievement difficulty | 1x | 0.5 / 1 / 1.5 / 2, affects required amounts |
| Ability cost | 1x | 0.5 / 1 / 1.5 / 2, affects ability point cost |
| Max learns for Damage/Speed/Defense Up | 5 | 5–40 |
| Max learns for Critical Reward | 20 | 5–20 |
| Spend Kill Value to complete achievements | Yes | See "Kill Value" |
| Kill Value to complete one achievement | 1000 | 500–5000 |
| Stat points gained per level | 1 | 1–10 |
| Days needed for one lossless reset | 100 | 50–600 |
| Can press N to show/hide the interface | Yes | |
| Can use stat points | Yes | |

---

## 8. Getting Started

1. **Early game**: build EXP and levels by eating and killing small creatures, steadily gaining points and stat points via "Character Level Up".
2. **Early abilities**: prioritize practical development perks like Gold Miner, Chopping Master, Double Gather and Fast Collection to greatly speed up your early progress.
3. **Combat focus**: stack Damage Up, Critical Reward and Bloodthirsty, then add Freeze Ability, Thorns or Firm Armor as needed.
4. **Stat allocation**: favor Health early for survival, then top up Sanity and Hunger later.
5. **Late game**: once points are plentiful, unlock character skill-port abilities (Engineering Tech, Soul Hop, Ghostly Friend, War God's Arsenal, Time Manager, etc.) to combine many characters' signature powers on one survivor.
6. **Tough achievements**: spend accumulated Kill Value to directly complete hard achievements (such as some boss bestiary entries) and quickly top up your points.

---

*All values listed are defaults; actual effects depend on your in-game settings and version.*
