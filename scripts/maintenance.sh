#!/bin/bash

set -e

BASE="$(cd "$(dirname "$0")/.." && pwd)"

COMPOSE="docker-compose -f $BASE/docker-compose.yml"
RUNTIME="$BASE/runtime"

case "$1" in

    on)
        echo "Enabling maintenance mode..."

        cp "$BASE/nginx/nginx-on.conf" \
           "$RUNTIME/default.conf"

        $COMPOSE exec maintenance-gateway nginx -t
        $COMPOSE exec maintenance-gateway nginx -s reload

        echo "Maintenance mode: ON"
        ;;

    off)
        echo "Disabling maintenance mode..."

        cp "$BASE/nginx/nginx-off.conf" \
           "$RUNTIME/default.conf"

        $COMPOSE exec maintenance-gateway nginx -t
        $COMPOSE exec maintenance-gateway nginx -s reload

        echo "Maintenance mode: OFF"
        ;;

    status)
        echo "Current configuration:"
        cat "$RUNTIME/default.conf"
        ;;

    restart)
        $COMPOSE restart maintenance-gateway
        ;;

    logs)
        $COMPOSE logs --tail=100 maintenance-gateway
        ;;

    *)
        echo "Usage:"
        echo "  ./scripts/maintenance.sh on"
        echo "  ./scripts/maintenance.sh off"
        echo "  ./scripts/maintenance.sh status"
        echo "  ./scripts/maintenance.sh restart"
        echo "  ./scripts/maintenance.sh logs"
        exit 1
        ;;

esac