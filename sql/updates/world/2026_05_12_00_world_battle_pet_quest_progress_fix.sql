-- Battle pet quest progress and trainer availability fixes.
-- Complements the questline restore by fixing missing turn-ins, one bad
-- objective entry, and trainer NPCs that exist in quest data but not in world.

UPDATE quest_objective
SET objectId = 66412
WHERE questId = 31908
  AND type = 11
  AND objectId = 0;

UPDATE creature_template
SET npcflag = npcflag | 2
WHERE entry = 66412;

INSERT IGNORE INTO creature_questender (id, quest) VALUES
(63626, 31891),
(63596, 31902),
(63626, 31903),
(63596, 31919),
(63626, 31921),
(63596, 31927),
(63626, 31929),
(63596, 31930),
(63626, 31952),
(63596, 31966),
(63626, 31967);

INSERT INTO quest_template_addon (
    ID, MaxLevel, AllowableClasses, SourceSpellID, PrevQuestID, NextQuestID,
    ExclusiveGroup, RewardMailTemplateID, RewardMailDelay, RequiredSkillID,
    RequiredSkillPoints, RequiredMinRepFaction, RequiredMaxRepFaction,
    RequiredMinRepValue, RequiredMaxRepValue, ProvidedItemCount, SpecialFlags,
    ScriptName
) VALUES (
    31573, 0, 0, 0, 0, 31574,
    0, 0, 0, 0,
    0, 0, 0,
    0, 0, 0, 0,
    ''
) ON DUPLICATE KEY UPDATE
    PrevQuestID = VALUES(PrevQuestID),
    NextQuestID = VALUES(NextQuestID),
    ExclusiveGroup = VALUES(ExclusiveGroup),
    SpecialFlags = VALUES(SpecialFlags);

CREATE TEMPORARY TABLE tmp_battle_pet_missing_trainer_spawns (
    npc MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY,
    map SMALLINT UNSIGNED NOT NULL,
    x FLOAT NOT NULL,
    y FLOAT NOT NULL
);

INSERT IGNORE INTO tmp_battle_pet_missing_trainer_spawns (npc, map, x, y) VALUES
(65655, 0, -10520, 297),
(65656, 0, -14448, 78),
(63194, 0, -12122, -142),
(66136, 1, 3537, 535),
(66137, 1, 589, 382),
(66372, 1, -918, 1666),
(66675, 571, 8609, 591);

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
FROM tmp_battle_pet_missing_trainer_spawns t
WHERE NOT EXISTS (SELECT 1 FROM creature c WHERE c.id = t.npc);

DROP TEMPORARY TABLE tmp_battle_pet_missing_trainer_spawns;
