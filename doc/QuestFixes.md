# Quest Fixes

## 2026-05-12 Cataclysm Prelude and Nordrassil

The Cataclysm prelude and Mount Hyjal fixes touch script hooks and world database data:

- Waters of Farseeing spell `94687` is registered to `spell_waters_of_farseeing_94687`.
- Waters of Farseeing grants credit `50054` for Horde quest `28805` and Alliance quest `28826`, then limits the screen effect to 5 seconds.
- Nordrassil duplicate Thrall creature `54168`, guid `293035`, is moved out of phase 1 so the interactable Thrall remains visible by himself.
- Thrall creature template `54313` is assigned `npc_thrall_nordrassil_summit` and explicitly keeps gossip flag `1` with gossip menu `12991`.
- For The Nordrassil Summit quest `29326`, Thrall exposes the existing gossip option and grants ceremony credit `54306`.
- Gossip menu `12991`, option `0`, must require gossip flag `1`; leaving the option flag as `0` prevents the client from offering the "I am ready." choice.

## 2026-05-12 Battle Pet Trainers

- Battle pet trainer NPCs, including Zonya the Sadist `66137`, explicitly keep gossip and questgiver flags while removing the capturable wild-pet flag. This keeps trainer clicks on the normal gossip/quest path instead of the client wild-pet interaction path.
- Zonya quest `31815` now turns in at Zonya, and follow-up quest `31817` now turns in at Merda Stronghoof `66372`, matching the quest completion text.

## 2026-05-12 Elemental Bonds: Doubt

- Aggra creature template `53519` is assigned `npc_aggra_elemental_bonds_doubt` and explicitly keeps gossip flag `1` with gossip menu `12938`.
- Gossip menu `12938`, option `0`, must use option type `1` and gossip flag `1`; leaving the option flag as `0` prevents the client from offering the "Aggra, I am ready to travel to the Abyssal Maw." choice.
- Selecting the option grants quest `29327` objective credit `53518` to unblock "Protect Thrall from the elements."

## 2026-05-13 Elemental Bonds: Doubt Cyclonas

- Cyclonas creature template `53524` is assigned `npc_cyclonas_elemental_bonds_doubt` and explicitly keeps gossip flag `1` with gossip menu `12883`.
- Gossip menu `12883`, option `0`, is restored as "I am ready, elemental. Take me to Thrall." with broadcast text `52127`, option type `1`, and gossip flag `1`.
- Selecting the Cyclonas option also grants quest `29327` objective credit `53518`, covering players who are already at Cyclonas on the "Protect Thrall from the elements" step.
