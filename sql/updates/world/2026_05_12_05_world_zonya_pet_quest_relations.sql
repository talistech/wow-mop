-- Correct the early Kalimdor battle pet trainer quest handoff.
-- Quest text and objectives point players to turn in at the defeated trainer:
-- 31815 at Zonya and 31817 at Merda. Wrong enders leave Zonya without the
-- expected quest marker and can make the interaction look empty.

DELETE FROM `creature_questender`
WHERE (`id`, `quest`) IN
((66136, 31815),
 (66137, 31817));

INSERT IGNORE INTO `creature_questender` (`id`, `quest`) VALUES
(66137, 31815),
(66372, 31817);

-- Keep the quest offer handoff explicit after completing Zonya.
INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`) VALUES
(66137, 31817);
