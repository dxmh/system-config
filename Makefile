rebuild:
	test -n "${FLAKE_TARGET}"
	darwin-rebuild switch --flake .#${FLAKE_TARGET}

clean:
	nix-collect-garbage
