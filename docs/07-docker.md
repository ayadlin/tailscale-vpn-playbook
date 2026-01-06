# Docker / Homelab

## Docker Compose Exit Node

See `docker/docker-compose.yml`.

### Steps
1) Create a **Tailscale auth key** (prefer reusable + preapproved)
2) Set `TS_AUTHKEY` and (optionally) `TS_HOSTNAME`
3) Start the stack:

```bash
cd docker
TS_AUTHKEY=tskey-xxxxxxxx docker compose up -d
```

### Advertise exit node
Inside the container:

```bash
docker exec -it tailscale-exit-node tailscale up --advertise-exit-node
```

> Approve the exit node in the Tailscale admin console.
