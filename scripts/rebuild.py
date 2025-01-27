#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p python3
#! nix-shell -p home-manager

import argparse
import subprocess
from typing import Union


def get_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--option", type=str)
    parser.add_argument("--host", type=str)
    parser.add_argument("--user", type=str, default=None)
    parser.add_argument("--target-host", type=str, default=None, dest="target_host")
    parser.add_argument("--build-host", type=str, default=None, dest="build_host")
    args = parser.parse_args()
    if args.option == "home" and not args.user:
        parser.error("user is required for home option")
    return args


def is_localhost(host: str, current_host: str) -> bool:
    return host == current_host


def rebuild_nixos(host: str, target_host: str, build_host: Union[str, None] = None):
    if not target_host:
        print(f"Rebuilding {host} for local machine")
        subprocess.run(["sudo", "nixos-rebuild", "switch", "--flake", f".#{host}"])
    else:
        if build_host:
            print(f"Rebuilding {host} for {target_host} on {build_host}")
            subprocess.run(
                [
                    # "sudo",
                    "nixos-rebuild",
                    "switch",
                    "--flake",
                    f".#{host}",
                    "--target-host",
                    target_host,
                    "--build-host",
                    build_host,
                ]
            )
        else:
            print(f"Rebuilding {host} for {target_host}")
            subprocess.run(
                [
                    "sudo",
                    "nixos-rebuild",
                    "switch",
                    "--flake",
                    f".#{host}",
                    "--target-host",
                    target_host,
                ]
            )


def rebuild_home(host: str, user: str):
    print(f"Rebuilding home on {host} for user {user}")
    subprocess.run(["home-manager", "switch", "--flake", f".#{user}@{host}"])


def main():
    args = get_args()
    current_host = subprocess.run(
        ["hostname"], capture_output=True, text=True
    ).stdout.strip()
    if args.option == "nixos":
        if not is_localhost(args.host, current_host) and not args.target_host:
            print(f"Current host is {current_host}, not {args.host}")
            return
        rebuild_nixos(args.host, args.target_host, args.build_host)
    elif args.option == "home":
        if not is_localhost(args.host, current_host):
            print(f"Current host is {current_host}, not {args.host}")
            return
        rebuild_home(args.host, args.user)
    elif args.option == "full":
        target_is_localhost = is_localhost(args.host, current_host)
        if args.build_host:
            print(f"Cannot rebuild home on {args.build_host}")
            return
        if not target_is_localhost and not args.target_host:
            print(f"Current host is {current_host}, not {args.host}")
            return
        if target_is_localhost:
            rebuild_nixos(args.host, "")
        else:
            rebuild_nixos(args.host, args.target_host)
        rebuild_home(args.host, args.user)
    else:
        args.print_help()


if __name__ == "__main__":
    main()
