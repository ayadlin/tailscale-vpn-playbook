# macOS (DNS + routing quirks)

macOS can be aggressive about DNS and interface ordering.

## Recommended defaults for coexistence

### Level 1 side‑by‑side
Keep the traditional VPN as DNS owner:

```bash
tailscale up --accept-dns=false
```

### If you need MagicDNS
If you want Tailscale to provide DNS for tailnet names:

```bash
tailscale up --accept-dns=true
```

…but ensure your traditional VPN is not trying to force a conflicting DNS resolver.

## Debugging

```bash
scutil --dns
route -n get default
netstat -rn | head
```
