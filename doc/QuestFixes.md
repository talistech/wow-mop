# Quest Fixes

## 2026-05-12 Cataclysm Prelude and Nordrassil

The Cataclysm prelude and Mount Hyjal fixes touch script hooks and world database data:

- Waters of Farseeing spell `94687` is registered to `spell_waters_of_farseeing_94687`.
- Waters of Farseeing grants credit `50054` for Horde quest `28805` and Alliance quest `28826`, then limits the screen effect to 5 seconds.
- Nordrassil duplicate Thrall creature `54168`, guid `293035`, is moved out of phase 1 so the interactable Thrall remains visible by himself.
- Thrall creature template `54313` is assigned `npc_thrall_nordrassil_summit` and explicitly keeps gossip flag `1` with gossip menu `12991`.
- For The Nordrassil Summit quest `29326`, Thrall exposes the existing gossip option and grants ceremony credit `54306`.
- Gossip menu `12991`, option `0`, must require gossip flag `1`; leaving the option flag as `0` prevents the client from offering the "I am ready." choice.
