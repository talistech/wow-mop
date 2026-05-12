-- Fix Waters of Farseeing quest credit script registration and prevent duplicate Thrall visibility at Nordrassil.

DELETE FROM `spell_script_names` WHERE `spell_id` = 94687 AND `ScriptName` = 'spell_waters_of_farseeing_94687';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(94687, 'spell_waters_of_farseeing_94687');

-- Keep the interactable Thrall (guid 293023, entry 54313) in the base phase and move the event duplicate out of phase 1.
UPDATE `creature` SET `phaseMask` = 2 WHERE `guid` = 293035 AND `id` = 54168 AND `map` = 1 AND `zoneId` = 616;

-- Ensure Thrall exposes and handles the "I am ready." ceremony option for The Nordrassil Summit.
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1, `gossip_menu_id` = 12991, `ScriptName` = 'npc_thrall_nordrassil_summit' WHERE `entry` = 54313;
UPDATE `gossip_menu_option` SET `OptionNpcflag` = 1 WHERE `MenuID` = 12991 AND `OptionID` = 0;
