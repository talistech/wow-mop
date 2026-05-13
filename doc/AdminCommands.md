# Admin Commands

## Damage AOE

`.damageaoe <damage> [radius] [all]`

- Applies direct physical damage from the GM to nearby NPC creatures.
- Radius defaults to `15` yards and is capped at `100` yards.
- Players are never damaged by this command.
- By default the command skips pets, guardians, totems, triggers, spirit-service creatures, and critters.
- Pass `all` as the third argument to include those utility creatures.

`.damageaeo` is kept as a compatibility alias for the same command.
