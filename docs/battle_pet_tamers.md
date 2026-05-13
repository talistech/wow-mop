# Battle Pet Tamers

Battle pet tamer creatures use normal gossip packets to enter the tamer script,
but the battle pet UI allows players to click them from pet battle range. Keep
their gossip validation aligned with `PETBATTLE_INTERACTION_DIST`; otherwise the
core rejects the click before `npc_battle_pet_tamer::OnGossipHello` can start the
battle.

When diagnosing a tamer that shows a quest marker but does nothing on click,
check `Player::GetNPCIfCanInteractWith` before changing quest relations or NPC
flags. A server-side distance rejection can look like a broken gossip/script
setup even when `npcflag`, `ScriptName`, and quest status are all correct.
