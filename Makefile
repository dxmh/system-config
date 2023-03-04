rebuild: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET}

rebuild-vm:
	sudo nixos-rebuild switch --flake .#parallels-vm

upgrade: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET} --recreate-lock-file --commit-lock-file
	make --no-print-directory homebrew

homebrew:
	/opt/homebrew/bin/brew update
	/opt/homebrew/bin/brew upgrade

clean:
	nix-collect-garbage

check:
	test -n "${FLAKE_TARGET}"
