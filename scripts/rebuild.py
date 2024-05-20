#!/usr/bin/env nix-shell
#! nix-shell -p python3 python311Packages.psutil home-manager
#! nix-shell -i python3

import argparse
import subprocess
import psutil
import shutil
import sys
import os

def rebuild_system(args):
    # If hardware-configuration.nix is not in the host directory, copy it there
    flake_hardware_config = f"/home/{args.user}/nix/flakes/nixos/hosts/local/{args.flake}/hardware-configuration.nix"
    if not os.path.exists(flake_hardware_config):
        shutil.copy("/etc/nixos/hardware-configuration.nix", flake_hardware_config)

    # If nothing is mounted at /boot, mount the boot drive
    with open("/proc/mounts", "r") as f:
        for line in f:
            if "/boot" in line:
                break
        subprocess.run(["mount", "/dev/disk/by-label/EFI-NIXOS", "/boot"])

    # Rebuild using the system configuration
    subprocess.run(["nixos-rebuild", "switch", "--flake", f"/home/{args.user}/nix/flakes/nixos#{args.flake}"])

def rebuild_home(args):
    # Kill eww
    for process in psutil.process_iter(["pid", "name"]):
        if process.info["name"] == ".eww-wrapped":
            process.kill()

    try:
        subprocess.run(["home-manager", "switch", "--flake", f"/home/{args.user}/nix/flakes/nixos#{args.user}@{args.flake}"])
    except Exception as e:
        print(f"Failed to rebuild home configuration: {e}", file=sys.stderr)

    # Restart eww
    if shutil.which("eww") is not None:
        subprocess.run(["eww", "open", "status-bar"])
        subprocess.run(["eww", "open", "workspaces-toolbar"])

    # Create pywal symlinks
    if shutil.which("wal") is not None:
        subprocess.run(["ln", "-sfn", f"/home/{args.user}/nix/flakes/nixos/config/wal/", f"/home/{args.user}/.config/"])

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="NixOS Rebuild Script",
        description="A simple script used to rebuild my NixOS systems using nix/flakes"
    )
    parser.add_argument(
        "-f", 
        "--flake",
        action="store",
        help="The flake used to rebuild the system",
        metavar="",
        required=True,
    )
    parser.add_argument(
        "-o", 
        "--option",
        action="store",
        help="Rebuild the system configuration, home configuration, or both",
        metavar="",
        required=True,
        choices=["system", "home", "full"],
    )
    parser.add_argument(
        "-u", 
        "--user",
        action="store",
        help="The username to pass to home manager (needed if rebuilding the home configuration)",
        metavar="",
        required=True,
    )
    args = parser.parse_args()

    if args.option == "full":
        rebuild_system(args)
        rebuild_system(args)
    elif args.option == "system":
        rebuild_system(args)
    elif args.option == "home":
        rebuild_home(args)
