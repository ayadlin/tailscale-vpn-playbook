# Kubernetes (Exit Node + Subnet Router)

## Prereqs
- A Kubernetes cluster where pods can use `NET_ADMIN` (often requires privileged or specific PSP/PSA allowances)
- A **Tailscale auth key** stored as a Kubernetes Secret

Create secret:

```bash
kubectl create secret generic tailscale-auth \
  --from-literal=TS_AUTHKEY=tskey-xxxxxxxx
```

## Deploy Exit Node

```bash
kubectl apply -f tailscale-exit-node.yaml
```

Then exec into pod and advertise exit node:

```bash
kubectl exec -it deploy/tailscale-exit-node -- tailscale up --advertise-exit-node
```

Approve in admin console.

## Deploy Subnet Router

Edit `ROUTES` env var then:

```bash
kubectl apply -f tailscale-subnet-router.yaml
```

Example ROUTES: `192.168.1.0/24,10.10.0.0/16`
