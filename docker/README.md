# Docker Compose Exit Node

## Start

```bash
cd docker
export TS_AUTHKEY=tskey-xxxxxxxxxxxxxxxx
export TS_HOSTNAME=docker-exit

docker compose up -d
```

## Advertise Exit Node

```bash
docker exec -it tailscale-exit-node tailscale up --advertise-exit-node
```

Approve in Tailscale admin console.
