# Linux (Debian/Ubuntu/Fedora/Arch)

## Install Tailscale

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --accept-dns=false
```

## Level 1 — Side‑by‑side

### WireGuard VPN (example)
Create `/etc/wireguard/wg0.conf`:

```ini
[Interface]
PrivateKey = <CLIENT_PRIVATE_KEY>
Address = 10.0.0.2/32
DNS = 9.9.9.9

[Peer]
PublicKey = <SERVER_PUBLIC_KEY>
Endpoint = <VPN_HOST>:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
```

Bring up:
```bash
sudo wg-quick up wg0
```

Verify routes:
```bash
ip route | grep -E "default|100\."
```

## Level 2 — Exit node server prerequisites

Enable forwarding:
```bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
```

Persist in `/etc/sysctl.d/99-tailscale-forwarding.conf`:
```conf
net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1
```

## Level 3 — VPN inside Tailscale (OpenVPN hint)
Bind OpenVPN server to the tailscale IP:
- find tailscale IP: `tailscale ip -4`
- set OpenVPN `local <tailscale-ip>`
