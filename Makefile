rebuild: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET}

update:
	nix flake lock --recreate-lock-file --commit-lock-file

clean:
	nix-collect-garbage

check:
	test -n "${FLAKE_TARGET}"
