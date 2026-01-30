# Claude AI Context

This file provides context for Claude AI when working with this project.

## Project Overview

This repository hosts interactive web applications using nginx in Docker containers. Currently includes two production-ready applications:
- **Meeting Cost Calculator**: Interactive tool for visualizing meeting costs in real-time
- **Project Name Race**: Fun racing game for team decision-making

The project is designed for easy expansion with additional static web applications.

## Live Site

**GitHub Pages**: https://bfd-kr.github.io/web-stuff/

- Main page: https://bfd-kr.github.io/web-stuff/
- Meeting Cost Calculator: https://bfd-kr.github.io/web-stuff/meeting-cost-calculator.html
- Project Name Race: https://bfd-kr.github.io/web-stuff/name-race.html

## Architecture

- **Web Server**: nginx (Alpine Linux based)
- **Content Type**: Static HTML/CSS/JS
- **Deployment**: Docker containerization + GitHub Pages (auto-deployed via GitHub Actions)
- **Port**: 80 (internal), configurable external port

## Key Files

- `Dockerfile`: Defines the nginx container configuration
- `webapp/static/`: Contains all static web content
  - `index.html`: Main landing page with app links
  - `meeting-cost-calculator.html`: Meeting cost tracking application
  - `name-race.html`: Interactive racing game with 6 unique strategies
- `run.sh`: Automated build and deployment script
- `.dockerignore`: Excludes unnecessary files from Docker builds
- `.github/workflows/deploy-pages.yml`: GitHub Actions workflow for auto-deploying to GitHub Pages
- `meeting-cost-calculator-prompts.txt`: Development history and prompts used to create the calculator

## Project Name Race Features

- **Customizable Racers**: 2-10 racers with editable names
- **Racer Emojis**: Dogs 🐕, Horses 🐎, Camels 🐫, Turtles 🐢
- **6 Racing Strategies** (each with unique visual effects):
  - 🚀 Fast Start/Fade - Leads early, fades at the end (golden glow)
  - ⚡ Comeback Surge - Slow start, dramatic finish (electric pulse)
  - 📈 Steady Pace - Consistent speed throughout (gentle pulse)
  - 🎲 Inconsistent - Wild variance, unpredictable (shake effect)
  - 💨 Sprint/Rest - Alternating bursts of speed (blur effect)
  - 🍀 Lucky - Normal speed with rare big jumps (sparkle effect)
- **Consecutive Race Mode**: Run multiple races automatically with progress indicator
- **Wins Over Time Chart**: Visual line chart tracking cumulative wins per racer
- **Win Tracking**: Per-racer tallies and per-strategy statistics
- **Fair Racing**: Simultaneous finish detection, no positional bias

### Strategy Balance (Realistic Meta-Game)

The racing strategies are balanced to create realistic team dynamics:

| Field Size | Spread | Meta |
|------------|--------|------|
| 2-3 racers | ~20-25% | Consistent strategies dominate (Fast Start favored) |
| 4-5 racers | ~12-15% | Transitional - still favors consistency |
| 6-7 racers | ~8-10% | Most balanced - any strategy can win |
| 8-10 racers | ~6-8% | High variance strategies benefit from chaos |

**Design Philosophy**: Small groups favor strong leaders, large groups favor underdogs - just like real team dynamics!

### Testing Strategy Balance

When modifying race strategies, validate changes across all field sizes:

```javascript
// Key metrics to check:
// 1. Ticks to finish (solo) - all strategies should be ~27 ticks
// 2. Win rate spread - lower is more balanced
// 3. Positional bias - Racer 1 vs Racer N should have equal win rates

// Run simulations with different racer counts:
// - 2 racers: High variance expected (~20-25% spread)
// - 3 racers: Default config (~15-20% spread)
// - 6-7 racers: Sweet spot (~8-10% spread)
// - 10 racers: Large field (~6-8% spread)
```

**No Positional Bias**: Testing confirmed all racer positions (1 through N) have equal win probability. The winner is determined purely by strategy, not position in the race.

### Race Configuration
- **Default racers**: 3
- **Minimum racers**: 2
- **Maximum racers**: 10
- **Available emojis**: 🐕 🐎 🐫 🐢

### Key Code Locations in name-race.html
- `calculateSpeed(strategy, progress)` - Strategy speed calculations (~line 877)
- `strategyNames` array - Strategy definitions (~line 730)
- `numRacers` variable - Racer count tracking (~line 737)
- `getRandomStrategy()` - Uses `strategyNames.length` (no magic numbers!)

## Meeting Cost Calculator Features

- **Real-time cost tracking**: Timer with start/stop/reset, calculates salary burn rate
- **Blended hourly rate**: Configurable rate per person
- **Number of attendees**: Visual representation with icons
- **Additional costs**:
  - Travel costs (# travelers × avg travel cost)
  - Venue/catering total
- **Tiered comparison items**: Shows what the meeting could buy, scaling with cost:
  - Cheap ($0-100): lattes, burgers, books
  - Medium ($100-1K): AirPods, iPads, guitars
  - Expensive ($1K-10K): Rolexes, motorcycles, engagement rings
  - Very Expensive ($10K-100K): Teslas, speedboats, Porsches
  - Insane ($100K+): houses, private jets, SpaceX seats
- **URL sharing**: Share meeting state via URL hash parameters
- **Dark mode**: Toggle between light and dark themes
- **Keyboard shortcuts**: Space (start/stop), R (reset), +/- (people), D (dark mode)
- **Achievements**: Unlockable badges for meeting milestones
- **Money animation**: Falling money that scales with burn rate

## Development Workflow

### Quick Start (Recommended)
```bash
./run.sh
```

### Manual Steps
1. Modify content in `webapp/static/`
2. Build Docker image: `nerdctl build -t web-apps .`
3. Run container: `nerdctl run -d -p 8080:80 --name web-apps-container web-apps`
4. Test at `http://localhost:8080`

### Current Applications
- Main page: `http://localhost:8080/`
- Meeting Cost Calculator: `http://localhost:8080/meeting-cost-calculator.html`
- Project Name Race: `http://localhost:8080/name-race.html`

## Git Workflow

### Repository Rules
- **Direct pushes to main are blocked** - all changes must go through pull requests
- **Merge commits and squash merges are disabled** - use rebase merging only
- PRs are auto-deployed to GitHub Pages via GitHub Actions

### Making Changes
1. Create a feature branch: `git checkout -b feature/my-feature`
2. Make atomic commits (one logical change per commit)
3. Push to origin: `git push -u origin feature/my-feature`
4. Create PR: `gh pr create --title "Title" --body "Description"`
5. Merge with rebase: `gh pr merge <pr-number> --rebase`
6. Clean up: `git checkout main && git pull && git branch -d feature/my-feature`

### Commit Guidelines
- **Atomic commits**: Each commit should represent one logical change
  - ✅ Good: "Add turtle emoji to racer options"
  - ✅ Good: "Fix strategy balance for 6-racer races"
  - ❌ Bad: "Add turtle, fix balance, update docs" (should be 3 commits)
- **Descriptive messages**: Explain what and why, not just how
- **Co-authorship**: When AI-assisted, include: `Co-Authored-By: Claude <noreply@anthropic.com>`

### Example PR Workflow
```bash
# Create branch and make changes
git checkout -b fix/strategy-balance
# ... make changes ...
git add webapp/static/name-race.html
git commit -m "Fix strategy balance for spicy racing strategies"

# Push and create PR
git push -u origin fix/strategy-balance
gh pr create --title "Fix strategy balance" --body "## Summary\n- Fixed balance\n\n## Test plan\n- Ran simulations"

# Merge (after review)
gh pr merge <pr-number> --rebase

# Clean up
git checkout main
git reset --hard origin/main
git branch -d fix/strategy-balance
```

## Future Enhancements

Potential additions to consider:
- Multiple web applications in separate directories
- Nginx configuration file for custom routing
- SSL/TLS support for HTTPS
- Environment-based configuration
- Health check endpoints
- Logging and monitoring setup

## Technical Decisions

### Why nginx Alpine?
- Minimal footprint (smaller image size)
- Security-focused (fewer packages = smaller attack surface)
- Fast startup and low resource usage

### Why Docker?
- Consistent deployment environment
- Easy to scale and replicate
- Portable across different systems
- Isolated from host system

## Common Tasks

### Adding New Static Content
1. Add files to `webapp/static/`
2. Rebuild the image
3. Deploy new container

### Custom nginx Configuration
Create `nginx.conf` and update Dockerfile:
```dockerfile
COPY nginx.conf /etc/nginx/nginx.conf
```

### Multiple Applications
Structure suggestion:
```
webapp/
├── app1/
│   └── static/
├── app2/
│   └── static/
└── shared/
    └── static/
```

## Maintenance Notes

- Keep base nginx image updated for security patches
- Monitor container resource usage
- Review logs regularly
- Backup important static content

## Questions to Consider

When extending this project:
- Do you need server-side processing? (Consider Node.js, Python, etc.)
- Do you need a database? (Add database service)
- Do you need SSL certificates? (Use Let's Encrypt)
- Do you need a reverse proxy? (nginx can handle this)
- Do you need load balancing? (nginx or external load balancer)
