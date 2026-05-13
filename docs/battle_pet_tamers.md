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

Tamer battle creation must finish server-side registration before sending
`SMSG_PET_BATTLE_FINALIZE_LOCATION`. The client can answer that packet
immediately, so sending it from the `PetBattle` constructor leaves a short window
where follow-up pet battle opcodes cannot find the battle. Validate both teams,
active pets, and the PvE source creature before exposing the battle to the
client.
