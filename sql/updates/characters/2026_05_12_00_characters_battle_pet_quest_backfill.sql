-- Backfill battle pet quest progress that was missed before pet battle wins,
-- trainer defeats, and wrapper quest objectives awarded credit.

INSERT INTO character_queststatus_objective (guid, objectiveId, amount) VALUES
(229, 268806, 1),
(229, 269048, 1)
ON DUPLICATE KEY UPDATE amount = GREATEST(character_queststatus_objective.amount, VALUES(`amount`));

UPDATE character_queststatus qs
SET qs.status = 1
WHERE qs.guid = 229
  AND qs.quest IN (31588, 31812)
  AND qs.status = 3
  AND NOT EXISTS (
      SELECT 1
      FROM world.quest_objective qo
      LEFT JOIN character_queststatus_objective cqo
        ON cqo.guid = qs.guid
       AND cqo.objectiveId = qo.id
      WHERE qo.questId = qs.quest
        AND COALESCE(cqo.amount, 0) < qo.amount
  );

INSERT INTO character_queststatus_objective (guid, objectiveId, amount)
SELECT qs.guid, wrapper_objective.id, wrapper_objective.amount
FROM character_queststatus qs
JOIN world.quest_objective wrapper_objective
  ON wrapper_objective.questId = qs.quest
 AND wrapper_objective.type = 11
JOIN world.quest_objective completed_tamer_objective
  ON completed_tamer_objective.type = 11
 AND completed_tamer_objective.objectId = wrapper_objective.objectId
 AND completed_tamer_objective.questId <> wrapper_objective.questId
JOIN character_queststatus_rewarded rewarded
  ON rewarded.guid = qs.guid
 AND rewarded.quest = completed_tamer_objective.questId
WHERE qs.status = 3
  AND qs.quest IN (31889, 31891, 31902, 31903, 31919, 31921, 31927, 31929, 31930, 31952, 31966, 31967)
ON DUPLICATE KEY UPDATE amount = GREATEST(character_queststatus_objective.amount, VALUES(`amount`));

UPDATE character_queststatus qs
SET qs.status = 1
WHERE qs.status = 3
  AND qs.quest IN (31889, 31891, 31902, 31903, 31919, 31921, 31927, 31929, 31930, 31952, 31966, 31967)
  AND NOT EXISTS (
      SELECT 1
      FROM world.quest_objective qo
      LEFT JOIN character_queststatus_objective cqo
        ON cqo.guid = qs.guid
       AND cqo.objectiveId = qo.id
      WHERE qo.questId = qs.quest
        AND COALESCE(cqo.amount, 0) < qo.amount
  );
