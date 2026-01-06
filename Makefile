.PHONY: help level1 level2 level3 docker-up k8s-exit k8s-subnet

help:
	@echo "Targets:"
	@echo "  make level1      # Side-by-side Tailscale + VPN (Linux/macOS)"
	@echo "  make level2      # Configure THIS Linux box as exit node (requires TS_AUTHKEY)"
	@echo "  make level3      # Prepare client to accept routes (Linux/macOS)"
	@echo "  make docker-up   # Start docker exit node (requires TS_AUTHKEY)"
	@echo "  make k8s-exit    # Apply Kubernetes exit-node manifest"
	@echo "  make k8s-subnet  # Apply Kubernetes subnet-router manifest"

level1:
	@bash scripts/linux/level1-side-by-side.sh

level2:
	@bash scripts/linux/level2-exit-node.sh

level3:
	@bash scripts/linux/level3-vpn-over-tailscale.sh

docker-up:
	@cd docker && TS_AUTHKEY=$${TS_AUTHKEY} docker compose up -d

k8s-exit:
	kubectl apply -f k8s/tailscale-exit-node.yaml

k8s-subnet:
	kubectl apply -f k8s/tailscale-subnet-router.yaml
