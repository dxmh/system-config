rebuild: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET}

upgrade: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET} --recreate-lock-file

clean:
	nix-collect-garbage

check:
	test -n "${FLAKE_TARGET}"
