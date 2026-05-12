# wow-mop

Private Mists of Pandaria 5.4.8 Build 18414 server source and operations repository.

This project is based on the Legends of Azeroth Pandaria 5.4.8 emulator and is maintained for a private LAN realm with Playerbots, Dockerized services, SQL update tracking, live validation scripts, and project-specific bug fixes.

## What Is Included

- MoP 5.4.8 Build 18414 authserver and worldserver source.
- Docker build support through the workspace-level `docker-compose.yml`.
- MySQL 8 based auth, characters, world, and playerbot databases.
- Playerbots integration and local configuration support.
- SQL update files under `sql/updates`.
- Project documentation under `doc`.
- Live validation and operational scripts in the workspace-level `scripts` directory.

This repository does not include Blizzard client files. Use your own legally obtained MoP 5.4.8 client for data extraction and gameplay.

## Repository Layout

Important source tree paths:

- `src/server` - authserver, worldserver, shared game systems, handlers, scripts.
- `src/server/game/BattlePet` - battle pet journal, battle, spawn, and trainer logic.
- `src/server/scripts` - scripted world, spell, creature, quest, and command behavior.
- `modules/mod_playerbots` - Playerbots module.
- `sql/base` - base database schema/data.
- `sql/updates/world` - world database migrations.
- `sql/updates/characters` - character database migrations.
- `doc` - project-specific fix notes and operational documentation.

Workspace-level paths used by the Docker setup:

- `/opt/wow/source` - this git repository.
- `/opt/wow/config` - rendered runtime config files.
- `/opt/wow/data` - extracted `dbc`, `maps`, `vmaps`, and `mmaps`.
- `/opt/wow/dbdata` - MySQL persistent data.
- `/opt/wow/logs` - server logs.
- `/opt/wow/scripts` - build, database, validation, and maintenance helpers.
- `/opt/wow/webadmin` - local web administration app.

## Requirements

For the Docker workflow:

- Linux host with Docker and Docker Compose.
- AMD64 CPU.
- Enough disk for source, build layers, MySQL data, extracted maps, and logs.
- MoP 5.4.8 Build 18414 enUS client for extraction.

For manual/native builds:

- GCC 13 or Clang 12+.
- CMake 3.27+.
- MySQL 5.7 or 8.0/8.1 client libraries.
- OpenSSL 1.1.1 or 3.0/3.1.
- Boost 1.81+ on Linux.

The maintained workflow for this repo is Docker, not a native host install.

## First-Time Setup

Run these from the workspace root, not from `source`:

```bash
cd /opt/wow
cp .env.example .env
```

Review `.env` and set at least:

- `SERVER_IP`
- `MYSQL_ROOT_PASSWORD`
- `WEB_ADMIN_USER`
- `WEB_ADMIN_PASSWORD`
- `WEB_ADMIN_SECRET`
- `SOAP_USER`
- `SOAP_PASSWORD`
- `CLIENT_DIR`

Build the server image:

```bash
./scripts/build.sh
```

Initialize databases:

```bash
./scripts/db-init.sh
```

This imports auth, characters, world, and Playerbots SQL. Treat it as destructive for an existing database unless you have a backup.

Extract client data:

```bash
./scripts/extract-client-data.sh
```

Create a GM account:

```bash
./scripts/create-account.sh USERNAME PASSWORD 3
```

Start the realm:

```bash
./scripts/start.sh
```

Point the client at the LAN realm in `WTF/Config.wtf`:

```text
SET realmlist SERVER_IP
```

Replace `SERVER_IP` with the value from `.env`.

## Daily Operations

Start services:

```bash
./scripts/start.sh
```

Stop services:

```bash
./scripts/stop.sh
```

Tail logs:

```bash
./scripts/logs.sh worldserver
./scripts/logs.sh authserver
```

Create a database backup:

```bash
./scripts/backup-db.sh
```

Run a SOAP command:

```bash
./scripts/soap-command.sh "server info"
```

Check containers directly:

```bash
docker compose ps
docker compose logs --tail=200 worldserver
```

## Building and Deploying Changes

The `authserver` compose service owns the Docker build definition, and both authserver and worldserver use the same image:

```bash
cd /opt/wow
docker compose --progress plain build authserver
docker compose up -d authserver worldserver
```

Use this after C++ changes. SQL-only changes normally need the SQL applied and then a worldserver restart if the data is loaded at startup.

## Database Updates

Keep persistent DB changes in versioned update files:

- World DB: `sql/updates/world/YYYY_MM_DD_NN_world_description.sql`
- Character DB: `sql/updates/characters/YYYY_MM_DD_NN_characters_description.sql`

Apply a world update manually:

```bash
cd /opt/wow
docker compose cp source/sql/updates/world/FILE.sql db:/tmp/FILE.sql
docker compose exec -T db sh -c "mysql -uroot -p$MYSQL_ROOT_PASSWORD world < /tmp/FILE.sql"
```

Apply a character update manually:

```bash
cd /opt/wow
docker compose cp source/sql/updates/characters/FILE.sql db:/tmp/FILE.sql
docker compose exec -T db sh -c "mysql -uroot -p$MYSQL_ROOT_PASSWORD characters < /tmp/FILE.sql"
```

If running the command outside the shell that loaded `.env`, substitute the actual password.

## Playerbots

Playerbots are enabled for this private realm. They are useful for solo and small-party testing, but the module is still sensitive to incomplete scripts, missing navigation data, and dungeon edge cases.

Useful validation commands:

```bash
./scripts/playerbot-live-gate-status.sh
./scripts/validate-playerbot-dungeon-live.sh
./scripts/check-instance-joinability.sh
```

Playerbots require enUS DBC data. Use an enUS MoP 5.4.8 client when extracting data.

## Web Admin

The local web admin service is defined in the workspace-level compose file.

Start it with the rest of the stack:

```bash
./scripts/start.sh
```

Configure credentials in `.env`:

- `WEB_ADMIN_USER`
- `WEB_ADMIN_PASSWORD`
- `WEB_ADMIN_SECRET`
- `SOAP_USER`
- `SOAP_PASSWORD`

The default bind address and port come from:

- `WEB_ADMIN_BIND`
- `WEB_ADMIN_PORT`

## LAN Security

This setup is intended for LAN-only use.

- Authserver binds to `${SERVER_IP}:3724`.
- Worldserver binds to `${SERVER_IP}:8085`.
- MySQL binds to `127.0.0.1:3306`.
- Web admin binds to `${WEB_ADMIN_BIND}:${WEB_ADMIN_PORT}`.

Do not port-forward these services to the public internet.

Optional firewall helper:

```bash
./scripts/firewall-lan-only.sh
```

## Fix Documentation

Document meaningful gameplay/server fixes in `doc`.

Recent examples:

- `doc/BattlePetFixes.md`
- `doc/QuestFixes.md`

When adding a fix:

1. Update code and SQL.
2. Add or update documentation in `doc`.
3. Build or run the narrowest useful validation.
4. Commit a focused changeset.
5. Push to the active remote branch or a feature branch.

## Git Workflow

Remote:

```bash
git@github.com:talistech/wow-mop.git
```

Prefer focused commits. Do not mix unrelated systems in one commit.

The local worktree may contain unrelated operational changes. Before committing, inspect staged files:

```bash
git status --short
git diff --cached --name-only
git diff --cached --stat
```

If direct push to `master` is blocked, push a feature branch:

```bash
git push origin HEAD:feature-name
```

## Troubleshooting

Worldserver startup:

```bash
docker compose logs --tail=300 worldserver
```

Battle pet loading:

```bash
docker compose logs worldserver | rg "battle pet|tamer team|World initialized"
```

Database shell:

```bash
docker compose exec db mysql -uroot -p world
```

Container health:

```bash
docker compose ps
```

Rebuild after C++ changes:

```bash
docker compose --progress plain build authserver
docker compose up -d authserver worldserver
```

## Upstream

This codebase is derived from Legends of Azeroth Pandaria 5.4.8.

Upstream project references:

- Discord: `https://discord.gg/byBCHbwJEg`
- License: GPL 2.0, see `COPYING.md`
- Contributors: see `THANKS.md`

## License

GPL 2.0. See `COPYING.md`.
