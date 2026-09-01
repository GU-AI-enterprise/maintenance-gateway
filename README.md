# GU.AI Maintenance Gateway

Maintenance gateway for guai.com.vn.

## Architecture

Internet
    ↓
Nginx Proxy Manager
    ↓
maintenance-gateway:80
    ↓
├── ON  → maintenance HTML
└── OFF → gu_ai_frontend:3000

## Requirements

- Docker
- Docker Compose
- Existing Docker network:
  `guai-enterprise_default`

## Start

```bash
docker compose up -d