rebuild: check
	time cachix watch-exec dxmh -- \
	  darwin-rebuild switch --flake .#${FLAKE_TARGET}

upgrade: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET} --recreate-lock-file --commit-lock-file

homebrew:
	/opt/homebrew/bin/brew update
	/opt/homebrew/bin/brew upgrade

clean:
	nix-collect-garbage

check:
	test -n "${FLAKE_TARGET}"
