# Web Apps

This repository hosts web applications served using nginx in Docker containers.

## Project Structure

```
.
├── webapp/
│   └── static/                        # Static content files (HTML, CSS, JS)
│       ├── index.html                 # Main entry point
│       ├── name-race.html             # Project Name Race game
│       └── meeting-cost-calculator.html  # Meeting Cost Calculator
├── Dockerfile                         # Docker configuration for nginx
├── run.sh                             # Build and run script
├── .dockerignore                      # Files to exclude from Docker build
├── .gitignore                         # Git exclusions
├── README.md                          # This file
└── claude.md                          # Claude AI context and documentation
```

## Included Apps

### 🏁 Project Name Race
An interactive racing game for deciding between project names or team options in a fun, engaging way!

**Features:**
- **Customizable Racers**: 2-10 racers with editable names (defaults: SynthLoad, BenchPress, StressKit)
- **Dynamic Racing Strategies**:
  - 🚀 Fast Start/Fade
  - ⚡ Comeback Surge
  - 📈 Steady Pace
  - 🎲 Inconsistent
- **Racer Type Selection**: Choose between Dogs 🐕, Horses 🐎, or Camels 🐫
- **Win Tracking**:
  - Per-racer win tallies
  - Per-strategy win statistics
  - Auto-reset when names change
- **Fair Racing**: True randomization with simultaneous finish detection
- **Responsive Layout**: Winner panel moves to sidebar on wider screens

Perfect for making decisions, team building, or just having fun!

Access it at: `http://localhost:8080/name-race.html`

### 💰 Meeting Cost Calculator
A comprehensive, interactive tool that helps teams visualize and track the financial impact of meetings in real-time.

**Core Features:**
- **Blended Hourly Rate**: Customizable salary input (defaults to $80/hour)
- **Number of Attendees**: Track costs across multiple participants
- **Live Timer**: Start/Stop/Reset functionality
- **Manual Time Entry**: HH:MM:SS format support
- **Real-time Cost Calculation**: Instant cost updates with cash register animation
- **Cost Metrics**: Per-second and per-minute burn rate display

**Interactive Elements:**
- **Meeting Presets**: Quick setup for Daily Standup, Sprint Planning, All Hands, or 1:1 meetings
- **Dynamic Visualizations**:
  - Animated people count with scale indicators
  - Meeting size warnings (color-coded)
  - Comparative cost displays (lattes, pizzas, flights, etc.)
  - Falling money animation that scales with burn rate
- **Progress Rings**: Visual gauges for time, people count, and total cost
- **Achievement System**: Track meeting efficiency milestones

**Additional Features:**
- **Dark Mode**: Toggle with localStorage persistence
- **Sound Effects**: Optional audio feedback (ticking, milestones, warnings)
- **Keyboard Shortcuts**: Space (start/stop), R (reset), +/- (people), D (dark mode)
- **Responsive Design**: Optimized horizontal layout for wider screens

Perfect for understanding the financial impact of meetings and encouraging more efficient use of time!

Access it at: `http://localhost:8080/meeting-cost-calculator.html`

## Getting Started

### Prerequisites

- Docker or nerdctl installed on your system
- Basic understanding of container commands

### Quick Start (Recommended)

Use the provided build and run script:

```bash
./run.sh
```

This script will:
- Build the Docker image
- Clean up any existing containers with the same name
- Run the container in detached mode
- Display access URLs and helpful commands

The application will be available at `http://localhost:8080`

To stop and remove the container:
```bash
nerdctl stop web-apps-container
nerdctl rm web-apps-container
```

### Manual Commands

Alternatively, you can build and run manually with nerdctl (or docker):

#### Building the Image

```bash
nerdctl build -t web-apps .
```

#### Running the Container

```bash
nerdctl run -d -p 8080:80 --name web-apps-container web-apps
```

#### Stopping and Removing the Container

```bash
nerdctl stop web-apps-container
nerdctl rm web-apps-container
```

Note: The `--rm` flag is not compatible with `-d` (detached mode) in nerdctl, so manual cleanup is required.

## Development

To modify the static content:

1. Edit files in the `webapp/static/` directory
2. Rebuild the Docker image
3. Run the new container

For local development without Docker, you can use any static web server:

```bash
# Using Python
python3 -m http.server 8080 --directory webapp/static

# Using Node.js
npx serve webapp/static -p 8080
```

## Docker Compose (Optional)

Create a `docker-compose.yml` for easier management:

```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "8080:80"
    restart: unless-stopped
```

Then use:
```bash
docker-compose up -d    # Start
docker-compose down     # Stop
```

## License

[Add your license here]
