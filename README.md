
# Tailscale + VPN Coexistence Playbook

> A practical reference for running Tailscale alongside traditional VPNs (WireGuard / OpenVPN / commercial VPNs) without breaking routing or DNS.

This repository documents **known-good patterns** for coordinating Tailscale with other VPN solutions across **Linux, macOS, and Windows**.

It is intentionally **boring, explicit, and reproducible**.

---

## Why this repo exists

Many people understand **Tailscale** *or* **traditional VPNs**, but run into problems when they try to use both at the same time:

- Internet drops when both are enabled  
- DNS resolution breaks or leaks  
- Exit nodes behave unexpectedly  
- macOS and Windows behave differently than Linux  

Almost all of these issues come down to:

- **default route ownership**
- **DNS resolver ownership**

This repo exists to **make those behaviors explicit**, document safe defaults, and provide repeatable setups.

---

## Important: what this repo *is* and *is not*

### What this repo **IS**
- A **reference and documentation project**
- A collection of **small convenience wrappers** around existing CLIs
- A place to **reason about routing and DNS behavior**
- A starting point for people new to Tailscale + VPN coexistence

### What this repo **IS NOT**
- ❌ It does **not** add new functionality to Tailscale  
- ❌ It does **not** bypass VPN provider restrictions  
- ❌ It does **not** modify firewalls automatically  
- ❌ It does **not** collect credentials, telemetry, or system data  
- ❌ It does **not** replace reading Tailscale or WireGuard docs  

If you already understand routing tables and DNS precedence well, you may not need this repo.

---

## The three patterns covered

### 1. Side-by-side (recommended for most people)

```
Tailscale → private device access (100.x)
VPN       → internet traffic
```

- VPN owns the default route (`0.0.0.0/0`)
- Tailscale routes only its own address space
- Safest and most common setup

---

### 2. Tailscale Exit Node (VPN replacement)

```
Client → Tailscale → Exit Node → Internet
```

- Uses a server you control as your VPN
- One tool, no commercial VPN required
- Exit node behavior made explicit and auditable

---

### 3. VPN inside Tailscale (advanced / edge cases)

```
Client → Tailscale → VPN server (behind NAT) → private subnet
```

- Useful when a VPN server is not publicly reachable
- Tailscale handles identity and reachability
- VPN handles subnet policy

---

## What the scripts actually do

The scripts in this repo intentionally **do very little**:

- toggle whether Tailscale manages DNS
- enable or disable exit-node usage
- accept or advertise routes
- print diagnostics to understand system state

They exist to:

- reduce copy‑paste mistakes
- make intent explicit
- provide a consistent baseline across operating systems

Everything they do can be replicated manually via the CLI or GUI.

---

## What’s included

- Linux, macOS, and Windows coverage  
- 5‑minute “Golden Path” setup guides  
- WireGuard and OpenVPN templates  
- Docker Compose exit node example  
- Kubernetes exit node + subnet router  
- Diagnostics scripts (routing, DNS, Tailscale state)  
- Security hardening checklist  
- Threat model & privacy notes  
- CI linting and release automation  

---

## Security & trust notes

- All scripts are **local only**
- No network calls beyond Tailscale / VPN CLIs
- No credentials are collected or transmitted
- `.env` and key material are explicitly `.gitignore`’d
- Every action maps directly to a documented CLI command

If anything here appears unsafe or misleading, please open an issue.

---

## Who this is for

- People combining Tailscale with an existing VPN
- Homelab and self‑hosted users
- Mixed Linux / macOS / Windows environments
- Anyone tired of debugging DNS and routing conflicts

---

## Feedback welcome

If you spot:

- incorrect assumptions
- unsafe defaults
- misleading explanations
- better patterns

please open an issue or PR.

This repo is meant to improve through review.

---

### License

MIT
