-- Fix battle pet tamers that were accidentally flagged as capturable wild pets.
-- The wild-pet flag causes the client to send pet capture interaction instead
-- of opening normal gossip/quest UI, which can disconnect players on click.

UPDATE `creature_template`
SET `npcflag` = (`npcflag` | 1) & ~1073741824,
    `ScriptName` = 'npc_battle_pet_tamer'
WHERE `entry` IN
(63194, 64330, 65648, 65651, 65655, 65656, 66126, 66135, 66136, 66137,
 66352, 66372, 66412, 66422, 66436, 66442, 66452, 66466, 66478, 66512,
 66515, 66518, 66520, 66522, 66550, 66551, 66552, 66553, 66557, 66635,
 66636, 66638, 66639, 66675, 66730, 66733, 66734, 66738, 66739, 66741,
 66815, 66819, 66822, 66824, 66918, 67370, 68462, 68463, 68464, 68465,
 73626);
