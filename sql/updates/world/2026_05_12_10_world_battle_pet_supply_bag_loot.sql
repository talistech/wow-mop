DELETE FROM `item_loot_template` WHERE `entry` IN (89125, 93146, 93147, 93148, 93149, 94207, 98095);

INSERT INTO `item_loot_template`
(`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
-- Sack of Pet Supplies: guaranteed useful pet supply.
(89125, 86143, 20, '', 1, 2, 4), -- Battle Pet Bandage
(89125, 43626, 20, '', 1, 2, 4), -- Happy Pet Snack
(89125, 43352, 20, '', 1, 2, 4), -- Pet Grooming Kit
(89125, 89906, 20, '', 1, 2, 4), -- Magical Mini-Treat
(89125, 71153, 20, '', 1, 2, 4), -- Magical Pet Biscuit
-- Common flavor/vendor drops.
(89125, 37431, 16.67, '', 2, 1, 1), -- Fetch Ball
(89125, 67356, 16.67, '', 2, 1, 1), -- Hair Ball
(89125, 90043, 16.67, '', 2, 1, 1), -- Rusty Pet Cage
(89125, 90044, 16.67, '', 2, 1, 1), -- Tattered Collar
(89125, 90047, 16.66, '', 2, 1, 1), -- Sack of Expired Pet Food
(89125, 90058, 16.66, '', 2, 1, 1), -- Well-Loved Toy
-- Rare drops.
(89125, 89587, 1, '', 0, 1, 1), -- Porcupette
(89125, 90048, 1, '', 0, 1, 1), -- Exquisite Murloc Leash
(89125, 92665, 1, '', 0, 1, 1), -- Flawless Elemental Battle-Stone
(89125, 92675, 1, '', 0, 1, 1), -- Flawless Beast Battle-Stone
(89125, 92676, 1, '', 0, 1, 1), -- Flawless Critter Battle-Stone
(89125, 92677, 1, '', 0, 1, 1), -- Flawless Flying Battle-Stone
(89125, 92678, 1, '', 0, 1, 1), -- Flawless Magic Battle-Stone
(89125, 92679, 1, '', 0, 1, 1), -- Flawless Aquatic Battle-Stone
(89125, 92680, 1, '', 0, 1, 1), -- Flawless Mechanical Battle-Stone
(89125, 92681, 1, '', 0, 1, 1), -- Flawless Undead Battle-Stone
(89125, 92682, 1, '', 0, 1, 1), -- Flawless Humanoid Battle-Stone
(89125, 92683, 1, '', 0, 1, 1), -- Flawless Dragonkin Battle-Stone
-- Pandaren/Fabled/Brawler pet supply bags use the same baseline table for now so none of them open empty.
(93146, 86143, 30, '', 1, 2, 4),
(93146, 89906, 25, '', 1, 2, 4),
(93146, 71153, 25, '', 1, 2, 4),
(93146, 43626, 20, '', 1, 2, 4),
(93147, 86143, 30, '', 1, 2, 4),
(93147, 89906, 25, '', 1, 2, 4),
(93147, 71153, 25, '', 1, 2, 4),
(93147, 43626, 20, '', 1, 2, 4),
(93148, 86143, 30, '', 1, 2, 4),
(93148, 89906, 25, '', 1, 2, 4),
(93148, 71153, 25, '', 1, 2, 4),
(93148, 43626, 20, '', 1, 2, 4),
(93149, 86143, 30, '', 1, 2, 4),
(93149, 89906, 25, '', 1, 2, 4),
(93149, 71153, 25, '', 1, 2, 4),
(93149, 43626, 20, '', 1, 2, 4),
(94207, 86143, 30, '', 1, 2, 4),
(94207, 89906, 25, '', 1, 2, 4),
(94207, 71153, 25, '', 1, 2, 4),
(94207, 43626, 20, '', 1, 2, 4),
(98095, 86143, 30, '', 1, 2, 4),
(98095, 89906, 25, '', 1, 2, 4),
(98095, 71153, 25, '', 1, 2, 4),
(98095, 43626, 20, '', 1, 2, 4);
