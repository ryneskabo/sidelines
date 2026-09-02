# Sidelines

## Status

🚧 Early development. Core architecture is being built out; not yet usable.

## Features

- **PGN viewer** — import a PGN, step through moves, follow annotated variations as a proper branching tree (not just the mainline)
- **Engine analysis** — live Stockfish evaluation via a backend analysis pool, streamed to the board as it deepens
- **Opening explorer** — see how a position has been played historically, with win/draw/loss stats per candidate move
- **Game database** — store and search games by player, event, opening, date, and result
- **Annotations** — attach comments and move annotations (NAGs) to any node in a game's variation tree

## Tech stack

| Layer      | Choice                                      |
|------------|----------------------------------------------|
| Frontend   | React + TypeScript, Vite, React Router (declarative mode), TanStack Query |
| Board/rules| chess.js, chessground                        |
| Backend    | Go, Echo                                     |
| Analysis   | Stockfish (UCI), pooled as goroutine workers |
| Database   | PostgreSQL                                   |

## Project structure

```
sidelines/
├── frontend/           React + Vite app
│   └── src/
│       ├── components/  Board, MoveList, AnalysisPanel, OpeningExplorer
│       ├── state/       Game tree store
│       ├── lib/         PGN parsing, API client
│       └── types/
├── backend/            Go API server
│   ├── cmd/server/      Entrypoint
│   ├── internal/
│   │   ├── api/          Echo handlers/routes
│   │   ├── engine/       Stockfish worker pool
│   │   └── db/           Queries, connection setup
│   └── migrations/       SQL schema
└── README.md
```

## Getting started

### Prerequisites

- Node.js (LTS)
- Go 1.22+
- PostgreSQL
- A local Stockfish binary on your `PATH` (or set `STOCKFISH_PATH`)

### Frontend

```bash
cd frontend
npm install
npm run dev
```

### Backend

```bash
cd backend
go mod tidy
go run ./cmd/server
```

The Vite dev server proxies `/api/*` requests to the Go server at `localhost:8080` — see `frontend/vite.config.ts`.

### Database

```bash
createdb sidelines
psql sidelines -f backend/migrations/0001_init.sql
```

## Roadmap

- [ ] PGN import + variation tree rendering
- [ ] Board + move list wired to game tree state
- [ ] Go API: game CRUD and search
- [ ] Stockfish worker pool + live analysis streaming
- [ ] Opening explorer (seed data + per-game aggregation)
- [ ] Annotation editor

## License

TBD
