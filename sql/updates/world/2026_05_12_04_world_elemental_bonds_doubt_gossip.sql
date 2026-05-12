-- Ensure Aggra exposes and handles the travel option for Elemental Bonds: Doubt.

UPDATE `creature_template` SET `npcflag` = `npcflag` | 1, `gossip_menu_id` = 12938, `ScriptName` = 'npc_aggra_elemental_bonds_doubt' WHERE `entry` = 53519;
UPDATE `gossip_menu_option` SET `OptionType` = 1, `OptionNpcflag` = 1 WHERE `MenuID` = 12938 AND `OptionID` = 0;
