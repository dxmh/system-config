rebuild: check
	time cachix watch-exec dxmh -- \
	  darwin-rebuild switch --flake .#${FLAKE_TARGET}

rebuild-vm:
	time cachix watch-exec dxmh -- \
	  sudo nixos-rebuild switch --flake .#parallels-vm

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

vmlist:
	pgrep -lf qemu

clean:
	nix-collect-garbage

check:
	test -n "${FLAKE_TARGET}"
