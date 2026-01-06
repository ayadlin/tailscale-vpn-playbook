# Why This Works (Deep Dive)

## The routing table is the control plane

When Tailscale and a VPN “coexist,” you’re really controlling **routes**:
- VPN typically installs default route: `0.0.0.0/0`
- Tailscale installs routes for tailnet peers: `100.64.0.0/10`

If both install `0.0.0.0/0`, traffic flaps.

## DNS is the second control plane

If both tools set DNS resolvers, you get:
- broken name resolution
- slow browsing
- split-horizon failures

That’s why `tailscale up --accept-dns=false` is the safest default when pairing with a VPN.

## Exit nodes are just default routes (but managed)

Exit nodes are a controlled way to make Tailscale own `0.0.0.0/0`.

## VPN inside Tailscale

Tailscale provides identity, reachability, and NAT traversal; the VPN provides subnet policy.
This is useful for:
- VPN server behind NAT
- lab/enterprise hub-and-spoke
