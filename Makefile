rebuild: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET}

rebuild-vm:
	sudo nixos-rebuild switch --flake .#parallels-vm

qemu-vm:
	nix run .#qemu-vm

upgrade: check
	darwin-rebuild switch --flake .#${FLAKE_TARGET} --recreate-lock-file --commit-lock-file
	make --no-print-directory homebrew

homebrew:
	/opt/homebrew/bin/brew update
	/opt/homebrew/bin/brew upgrade

vmlist:
	pgrep -lf qemu

clean:
	nix-collect-garbage

check:
	test -n "${FLAKE_TARGET}"
