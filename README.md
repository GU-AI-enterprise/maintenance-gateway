# GU.AI Maintenance Gateway

Maintenance gateway for `guai.com.vn`.

## Architecture

```text
Internet
    ↓
Nginx Proxy Manager
    ↓
maintenance-gateway:80
    ↓
├── ON  → Maintenance HTML
└── OFF → GU.AI Frontend
```

## Requirements

- Docker
- Docker Compose
- Existing Docker network: `guai-enterprise_default`

## Start

```bash
docker-compose up -d
```

## Maintenance

### Bật maintenance

```bash
cp nginx/nginx-on.conf runtime/default.conf
docker exec maintenance-gateway nginx -t
docker exec maintenance-gateway nginx -s reload
```

### Tắt maintenance

```bash
cp nginx/nginx-off.conf runtime/default.conf
docker exec maintenance-gateway nginx -t
docker exec maintenance-gateway nginx -s reload
```

## Deploy

Mọi thay đổi được push lên branch `main` sẽ được GitHub Actions tự động deploy lên server.

```bash
git add .
git commit -m "update maintenance"
git push origin main
```

GitHub Actions sẽ:

```text
git push
   ↓
GitHub Actions
   ↓
SSH → Server
   ↓
git pull
   ↓
Update configuration
   ↓
nginx -t
   ↓
nginx reload
```

## Project Structure

```text
maintenance-gateway/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── html/
│   └── index.html
├── nginx/
│   ├── nginx-on.conf
│   └── nginx-off.conf
├── runtime/
│   └── default.conf
├── docker-compose.yml
└── README.md
```