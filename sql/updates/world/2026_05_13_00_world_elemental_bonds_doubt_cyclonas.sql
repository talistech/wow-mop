-- Restore Cyclonas' missing Elemental Bonds: Doubt gossip option.

UPDATE `creature_template`
SET `npcflag` = `npcflag` | 1,
    `gossip_menu_id` = 12883,
    `ScriptName` = 'npc_cyclonas_elemental_bonds_doubt'
WHERE `entry` = 53524;

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 12883 AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcflag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(12883, 0, 0, 'I am ready, elemental. Take me to Thrall.', 52127, 1, 1, 0, 0, 0, 0, '', 0, 15595);
