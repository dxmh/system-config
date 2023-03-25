rebuild: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET} 2>&1 | nom

update:
	nix flake lock --recreate-lock-file --commit-lock-file \
		--log-format internal-json -v 2>&1 | nom --json

clean:
	nix-collect-garbage 2>&1 | nom

check:
	test -n "${FLAKE_TARGET}"
