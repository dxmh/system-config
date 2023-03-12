{pkgs, ...}: {
  systemd.services.backup-tank = {
    description = "Backup of tank ZFS pool";
    startAt = "22:00:00";
    path = with pkgs; [cryptsetup rsync];
    onFailure = ["systemd-status-email@%n.service"];
    script = ''
      set -euxo pipefail

      neo_device=/dev/disk/by-id/ata-ST4000DM004-2U9104_WW601N39
      choi_device=/dev/disk/by-id/ata-ST4000DM004-2U9104_WW601PDS

      # Check disks are attached
      if ls $neo_device 2>/dev/null; then
        zfs_pool=neo
        device=$neo_device
        cryptsetup_name=luks_WW601N39
      elif ls $choi_device 2>/dev/null; then
        zfs_pool=choi
        device=$choi_device
        cryptsetup_name=luks_WW601PDS
      else
        echo "No backup disks present" >&2
        exit 1
      fi

      # Unlock the LUKS volume if not already active
      cryptsetup status $cryptsetup_name ||
        cryptsetup open $device $cryptsetup_name \
          --key-file /etc/luks_keyfile.bin

      # Import pool if not already imported
      zpool status $zfs_pool ||
        zpool import $zfs_pool

      # Check filesystem is mounted
      if ! findmnt /$zfs_pool; then
        echo "Filesystem not mounted at /$zfs_pool" >&2
        exit 2
      fi

      # Do the transfer
      rsync -avhHAPi --delete --exclude=".zfs" /tank/ /$zfs_pool/tank-rsync/

      # Make a snapshot
      zfs snapshot "$zfs_pool/tank-rsync@rsync-$(date +%Y_%m_%d-%H%M)"

      # If 7 days have passed since last scrub, start one and wait for
      # completion
      last_scrub="$(zpool status $zfs_pool \
        | sed -n 's/.*scrub repaired .* on \(.*\)$/\1/p')"
      last_scrub_epoch=$(date +%s -d "$last_scrub")
      last_week_epoch=$(date +%s -d "last week")
      if [ "$last_scrub_epoch" -lt "$last_week_epoch" ]; then
        zpool scrub $zfs_pool
        while sleep 1200; do
          zpool status $zfs_pool | grep -A2 'scrub in progress' || break
        done
      fi

      # Clean up
      zpool export $zfs_pool
      cryptsetup close $cryptsetup_name
      eject $device
      echo Complete
    '';
  };
}
