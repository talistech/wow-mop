-- Restore Battle Pet trainer questline exposure.
-- The old import only kept many quest_template rows; most NPC starter/ender
-- relations were missing, and the Alliance Eastern Kingdoms wrapper quest
-- existed only in locale/POI-style data.

-- Quest 31902 is the Alliance counterpart of 31903.
CREATE TEMPORARY TABLE tmp_battle_pet_quest_template_31902 AS
SELECT * FROM quest_template WHERE ID = 31903;

UPDATE tmp_battle_pet_quest_template_31902
SET
    ID = 31902,
    AllowableRaces = 18875469,
    FlagsEx = 2176,
    PortraitGiverName = '',
    PortraitTurnInText = 'Wow! You are truly impressive.',
    PortraitTurnInName = 'Audrey Burnhep',
    VerifiedBuild = 18414;

INSERT IGNORE INTO quest_template
SELECT * FROM tmp_battle_pet_quest_template_31902;

DROP TEMPORARY TABLE tmp_battle_pet_quest_template_31902;

CREATE TEMPORARY TABLE tmp_battle_pet_quest_addon_31902 AS
SELECT * FROM quest_template_addon WHERE ID = 31903;

UPDATE tmp_battle_pet_quest_addon_31902
SET ID = 31902;

INSERT IGNORE INTO quest_template_addon
SELECT * FROM tmp_battle_pet_quest_addon_31902;

DROP TEMPORARY TABLE tmp_battle_pet_quest_addon_31902;

INSERT IGNORE INTO quest_objective (questId, id, `index`, type, objectId, amount, flags, description)
SELECT 31902, id, `index`, type, objectId, amount, flags, description
FROM quest_objective
WHERE questId = 31903;

INSERT IGNORE INTO quest_poi (QuestID, Idx1, ObjectiveIndex, QuestObjectiveId, MapID, WorldMapAreaId, Floor, Priority, Flags, VerifiedBuild)
SELECT 31902, Idx1, ObjectiveIndex, QuestObjectiveId, MapID, WorldMapAreaId, Floor, Priority, Flags, VerifiedBuild
FROM quest_poi
WHERE QuestID = 31903;

INSERT IGNORE INTO quest_poi_points (QuestID, BlobIndex, Idx1, Idx2, X, Y, VerifiedBuild)
SELECT 31902, BlobIndex, Idx1, Idx2, X, Y, VerifiedBuild
FROM quest_poi_points
WHERE QuestID = 31903;

INSERT IGNORE INTO creature_queststarter (id, quest) VALUES
(63014, 31550),
(63014, 31308),
(63014, 31785),
(63014, 31309),
(63596, 32008),
(63596, 31966),
(63596, 31902),
(63596, 31889),
(63596, 31927),
(63596, 31919),
(63596, 31930),
(63596, 31593),
(63596, 31316),
(63596, 31591),
(63596, 31821),
(63596, 31592),
(63596, 32863),
(64330, 31693),
(64330, 31724),
(65648, 31725),
(65651, 31726),
(65651, 31781),
(64582, 32863),
(64572, 32863),
(66730, 31953),
(63626, 31967),
(63626, 31903),
(63626, 31891),
(63626, 31929),
(63626, 31921),
(63626, 31952),
(63626, 31590),
(63626, 31588),
(63626, 31827),
(63626, 31589),
(63626, 32009),
(63626, 32863),
(63626, 31812),
(66824, 31986),
(66466, 31977),
(66557, 31981),
(66557, 31982),
(66557, 31920),
(66557, 31926),
(66422, 31918),
(66422, 31904),
(66135, 31814),
(66135, 31819),
(66819, 31972),
(66815, 31973),
(66822, 31974),
(66522, 31980),
(66635, 31931),
(66636, 31932),
(66638, 31933),
(66639, 31934),
(66352, 31871),
(66436, 31905),
(66452, 31906),
(66442, 31907),
(66412, 31908),
(66478, 31910),
(66512, 31911),
(66518, 31913),
(66520, 31914),
(66515, 31912),
(66550, 31922),
(66551, 31923),
(66552, 31924),
(66553, 31925),
(66734, 31955),
(66733, 31954),
(66738, 31956),
(66739, 31957);

INSERT IGNORE INTO creature_questender (id, quest) VALUES
(63014, 31550),
(63014, 31308),
(63014, 31785),
(63014, 31309),
(63596, 31984),
(63596, 31917),
(63596, 32008),
(63596, 31981),
(63596, 31593),
(63596, 31591),
(63596, 31821),
(63596, 31592),
(63596, 31975),
(63596, 31976),
(63596, 31985),
(63596, 32863),
(64330, 31316),
(64330, 31693),
(65648, 31724),
(65651, 31725),
(65651, 31781),
(64582, 32863),
(64572, 32863),
(66730, 31953),
(63626, 32863),
(63626, 32009),
(63626, 31589),
(63626, 31827),
(63626, 31588),
(63626, 31590),
(63626, 31983),
(63626, 31918),
(63626, 31982),
(63626, 31977),
(63626, 31980),
(63626, 31986),
(66557, 31920),
(66557, 31926),
(66422, 31870),
(66422, 31904),
(66135, 31813),
(66135, 31819),
(66819, 31972),
(66815, 31973),
(66822, 31974),
(66126, 31812),
(66635, 31931),
(66636, 31932),
(66638, 31933),
(66639, 31934),
(66352, 31871),
(66436, 31905),
(66452, 31906),
(66442, 31907),
(66412, 31908),
(66478, 31910),
(66512, 31911),
(66518, 31913),
(66520, 31914),
(66515, 31912),
(66550, 31922),
(66551, 31923),
(66552, 31924),
(66553, 31925),
(66734, 31955),
(66733, 31954),
(66738, 31956),
(66739, 31957);

-- Active single-trainer quests that were not covered by the legacy relation
-- import. These are inferred from their unique defeat objective and chain
-- position; deprecated placeholder/wrapper quests are intentionally omitted.
INSERT IGNORE INTO creature_queststarter (id, quest) VALUES
(66126, 31813),
(66136, 31815),
(66137, 31817),
(65655, 31850),
(65656, 31851),
(63194, 31852),
(66136, 31854),
(66137, 31862),
(66372, 31870),
(66372, 31872),
(66522, 31915),
(66522, 31916),
(66675, 31928),
(66675, 31935),
(66741, 31951),
(66824, 31970),
(66824, 31971),
(68464, 32440);

INSERT IGNORE INTO creature_questender (id, quest) VALUES
(66136, 31814),
(66136, 31815),
(66137, 31817),
(65655, 31850),
(65656, 31851),
(63194, 31852),
(66136, 31854),
(66137, 31862),
(66372, 31872),
(66522, 31915),
(66522, 31916),
(66675, 31928),
(66675, 31935),
(66741, 31951),
(66824, 31970),
(66824, 31971),
(68464, 32440);

CREATE TEMPORARY TABLE tmp_battle_pet_trainer_spawns (
    npc MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
    map SMALLINT UNSIGNED NOT NULL,
    x FLOAT NOT NULL,
    y FLOAT NOT NULL
);

INSERT IGNORE INTO tmp_battle_pet_trainer_spawns (npc, map, x, y) VALUES
(65651, 0, -9415, -2334),
(66135, 1, -222, -3165),
(66352, 1, -4667, 1289),
(66412, 1, 7564, -2446),
(66422, 1, -3707, -1579),
(66436, 1, -4654, -3802),
(66442, 1, 4951, -624),
(66452, 1, -4933, -1836),
(66466, 1, 6149, -5028),
(66478, 0, 66, -4000),
(66512, 0, 2295, -4987),
(66515, 0, -6513, -1111),
(66518, 0, -10230, -4008),
(66520, 0, -7983, -1270),
(66522, 0, -11141, -1835),
(66550, 530, -217, 2218),
(66551, 530, 242, 8608),
(66552, 530, -1779, 6927),
(66553, 530, -2084, 5368),
(66557, 530, -3479, 2547),
(66635, 571, 5176.93, -73.85),
(66636, 571, 5432, 79),
(66638, 571, 2693, 317),
(66639, 571, 5445, -1261),
(66730, 870, 1131, -1897),
(66815, 646, 856, 509),
(66819, 1, 5270, -3535),
(66822, 0, -4152, -5420),
(66824, 1, -9761, -1072);

INSERT INTO creature (
    id, map, zoneId, areaId, spawnMask, phaseMask, phaseId, phaseGroup,
    modelid, equipment_id, position_x, position_y, position_z, orientation,
    spawntimesecs, spawntimesecs_max, wander_distance, currentwaypoint,
    curhealth, curmana, MovementType, npcflag, npcflag2, unit_flags,
    unit_flags2, dynamicflags, ScriptName, walk_mode, VerifiedBuild
)
SELECT
    t.npc,
    t.map,
    COALESCE((SELECT c.zoneId FROM creature c WHERE c.map = t.map ORDER BY POW(c.position_x - t.x, 2) + POW(c.position_y - t.y, 2) LIMIT 1), 0),
    COALESCE((SELECT c.areaId FROM creature c WHERE c.map = t.map ORDER BY POW(c.position_x - t.x, 2) + POW(c.position_y - t.y, 2) LIMIT 1), 0),
    1,
    1,
    0,
    0,
    0,
    0,
    t.x,
    t.y,
    COALESCE((SELECT c.position_z FROM creature c WHERE c.map = t.map ORDER BY POW(c.position_x - t.x, 2) + POW(c.position_y - t.y, 2) LIMIT 1), 0),
    0,
    300,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    '',
    0,
    18414
FROM tmp_battle_pet_trainer_spawns t
WHERE NOT EXISTS (SELECT 1 FROM creature c WHERE c.id = t.npc);

DROP TEMPORARY TABLE tmp_battle_pet_trainer_spawns;
