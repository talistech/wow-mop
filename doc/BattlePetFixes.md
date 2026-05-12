# Battle Pet Fixes

## 2026-05-12 Quest and Trainer Repair

This set of fixes restores the battle pet onboarding flow, trainer battles, and pet supply rewards.

- Battle pet loadout slots are persisted as raw account battle pet ids, matching the journal ids used by the client.
- Pet battle wins, captures, NPC trainer wins, PvP wins, and defeated species now satisfy quest objectives.
- Learning the Ropes and Level Up receive explicit quest credit from pet battle and pet level events.
- On The Mend adds a temporary heal gossip option to Seikwa and Murog when the related quest is incomplete.
- Battle pet tamers expose a server-side `Let's battle!` gossip option through `npc_battle_pet_tamer`.
- Battle pet tamers use normal gossip, not the capturable wild-pet NPC flag, so trainer clicks open gossip and quest UI instead of client pet capture interaction.
- Trainer battles load teams from `battle_pet_tamer_team`, allowing up to three configured pets per trainer.
- Trainer AI swaps to the next living pet after the active pet is defeated.
- Trainer pets cannot be trapped and are restored after the battle.
- Sack of Pet Supplies and related pet supply bags now have loot templates so they do not open empty.

Live validation after deploy:

- `battle_pet_tamer_team` has 137 pet rows for 51 tamers.
- Zonya the Sadist has three configured level 7 pets: Acidous, Constrictor, and Odoron.
- Worldserver startup loads `137 battle pet tamer team pets` without invalid species errors.
- `item_loot_template` for item `89125` has 23 loot rows.
