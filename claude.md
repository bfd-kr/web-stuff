# Claude AI Context

This file provides context for Claude AI when working with this project.

## Project Overview

This repository hosts interactive web applications using nginx in Docker containers. Currently includes two production-ready applications:
- **Meeting Cost Calculator**: Interactive tool for visualizing meeting costs in real-time
- **Project Name Race**: Fun racing game for team decision-making

The project is designed for easy expansion with additional static web applications.

## Architecture

- **Web Server**: nginx (Alpine Linux based)
- **Content Type**: Static HTML/CSS/JS
- **Deployment**: Docker containerization
- **Port**: 80 (internal), configurable external port

## Key Files

- `Dockerfile`: Defines the nginx container configuration
- `webapp/static/`: Contains all static web content
  - `index.html`: Main landing page with app links
  - `meeting-cost-calculator.html`: Meeting cost tracking application
  - `name-race.html`: Interactive racing game
- `run.sh`: Automated build and deployment script
- `.dockerignore`: Excludes unnecessary files from Docker builds
- `meeting-cost-calculator-prompts.txt`: Development history and prompts used to create the calculator

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

## Future Enhancements

Potential additions to consider:
- Multiple web applications in separate directories
- Nginx configuration file for custom routing
- SSL/TLS support for HTTPS
- Environment-based configuration
- CI/CD pipeline for automated deployments
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
