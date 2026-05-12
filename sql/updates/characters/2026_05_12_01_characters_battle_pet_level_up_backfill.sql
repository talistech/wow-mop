-- Backfill active "Level Up!" battle pet quests for accounts that already own a level 3+ battle pet.

INSERT INTO `character_queststatus_objective` (`guid`, `objectiveId`, `amount`)
SELECT cqs.`guid`, qo.`id`, 1
FROM `character_queststatus` cqs
JOIN `characters` c ON c.`guid` = cqs.`guid`
JOIN `account_battle_pet` abp ON abp.`accountId` = c.`account`
JOIN `world`.`quest_objective` qo ON qo.`questId` = cqs.`quest`
WHERE cqs.`status` = 3
  AND qo.`type` = 0
  AND qo.`objectId` = 65876
  AND abp.`level` >= 3
GROUP BY cqs.`guid`, qo.`id`
ON DUPLICATE KEY UPDATE `amount` = GREATEST(`amount`, VALUES(`amount`));

UPDATE `character_queststatus` cqs
JOIN `characters` c ON c.`guid` = cqs.`guid`
JOIN `account_battle_pet` abp ON abp.`accountId` = c.`account`
JOIN `world`.`quest_objective` qo ON qo.`questId` = cqs.`quest`
SET cqs.`status` = 1
WHERE cqs.`status` = 3
  AND qo.`type` = 0
  AND qo.`objectId` = 65876
  AND abp.`level` >= 3;
