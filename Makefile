rebuild: check
	time cachix watch-exec dxmh -- \
	  darwin-rebuild switch --flake .#${FLAKE_TARGET}

upgrade: check
	cachix watch-exec dxmh -- \
	  darwin-rebuild switch --flake .#${FLAKE_TARGET} --recreate-lock-file --commit-lock-file
	@# Cache the flake's inputs
	nix flake archive --json \
	  | jq -r '.path,(.inputs|to_entries[].value.path)' \
	  | cachix push dxmh
	make homebrew

homebrew:
	/opt/homebrew/bin/brew update
	/opt/homebrew/bin/brew upgrade

clean:
	nix-collect-garbage

check:
	test -n "${FLAKE_TARGET}"
