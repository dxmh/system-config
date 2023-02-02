rebuild: check
	time cachix watch-exec dxmh -- \
	  darwin-rebuild switch --flake .#${FLAKE_TARGET}

upgrade: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET} --recreate-lock-file --commit-lock-file

clean:
	nix-collect-garbage

check:
	test -n "${FLAKE_TARGET}"
