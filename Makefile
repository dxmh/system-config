rebuild: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET}

upgrade: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET} --recreate-lock-file --commit-lock-file
	make --no-print-directory homebrew

clean:
	nix-collect-garbage

check:
	test -n "${FLAKE_TARGET}"
