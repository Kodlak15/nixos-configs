{pkgs ? <nixpkgs>, ...}: let
  src = pkgs.fetchFromGitHub {
    owner = "coollabsio";
    repo = "coolify";
    rev = "v4.0.0-beta.319";
    hash = "sha256-ervcdWuy+zHaNjoNI5Ei7DvdSYxlS3BPIvMwUkDM8dU=";
  };
in
  pkgs.writeShellApplication {
    name = "coolify";
    runtimeInputs = with pkgs; [
      curl
      docker
    ];
    text = ''
      mkdir -p "$out/bin"
      mkdir -p "$out/bin/{source,ssh,applications,databases,backups,services,proxy,webhooks-during-maintenance}"
      mkdir -p "$out/bin/ssh/{keys,mux}"
      mkdir -p "$out/bin/proxy/dynamic"

      curl -fsSL https://cdn.coollabs.io/coolify/docker-compose.yml -o "$out/bin/source/docker-compose.yml"
      curl -fsSL https://cdn.coollabs.io/coolify/docker-compose.prod.yml -o "$out/bin/source/docker-compose.prod.yml"
      curl -fsSL https://cdn.coollabs.io/coolify/.env.production -o "$out/bin/source/.env"
      curl -fsSL https://cdn.coollabs.io/coolify/upgrade.sh -o "$out/bin/source/upgrade.sh"

      chown -R 9999:root "$bin/out"
      chmod -R 400 "$bin/out"

      sed -i "s|APP_ID=.*|APP_ID=$(openssl rand -hex 16)|g" "$out/bin/source/.env"
      sed -i "s|APP_KEY=.*|APP_KEY=base64:$(openssl rand -base64 32)|g" "$out/bin/source/.env"
      sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=$(openssl rand -base64 32)|g" "$out/bin/source/.env"
      sed -i "s|REDIS_PASSWORD=.*|REDIS_PASSWORD=$(openssl rand -base64 32)|g" "$out/bin/source/.env"
      sed -i "s|PUSHER_APP_ID=.*|PUSHER_APP_ID=$(openssl rand -hex 32)|g" "$out/bin/source/.env"
      sed -i "s|PUSHER_APP_KEY=.*|PUSHER_APP_KEY=$(openssl rand -hex 32)|g" "$out/bin/source/.env"
      sed -i "s|PUSHER_APP_SECRET=.*|PUSHER_APP_SECRET=$(openssl rand -hex 32)|g" "$out/bin/source/.env"

      ls ${src} > "$out/bin/ls"
    '';
  }
# {pkgs ? <nixpkgs>, ...}:
# pkgs.stdenv.mkDerivation rec {
#   name = "coolify";
#   src = pkgs.fetchFromGitHub {
#     owner = "coollabsio";
#     repo = "${name}";
#     rev = "v4.0.0-beta.319";
#     hash = "sha256-ervcdWuy+zHaNjoNI5Ei7DvdSYxlS3BPIvMwUkDM8dU=";
#   };
#
#   nativeBuildInputs = with pkgs; [curl];
#
#   installPhase = ''
#     mkdir -p $out/bin
#     mkdir -p $out/bin/{source,ssh,applications,databases,backups,services,proxy,webhooks-during-maintenance}
#     mkdir -p $out/bin/ssh/{keys,mux}
#     mkdir -p $out/bin/proxy/dynamic
#
#     curl -fsSL https://cdn.coollabs.io/coolify/docker-compose.yml -o $out/bin/source/docker-compose.yml
#     curl -fsSL https://cdn.coollabs.io/coolify/docker-compose.prod.yml -o $out/bin/source/docker-compose.prod.yml
#     curl -fsSL https://cdn.coollabs.io/coolify/.env.production -o $out/bin/source/.env
#     curl -fsSL https://cdn.coollabs.io/coolify/upgrade.sh -o $out/bin/source/upgrade.sh
#
#     chown -R 9999:root $bin/out
#     chmod -R 400 $bin/out
#
#     sed -i "s|APP_ID=.*|APP_ID=$(openssl rand -hex 16)|g" $out/bin/source/.env
#     sed -i "s|APP_KEY=.*|APP_KEY=base64:$(openssl rand -base64 32)|g" $out/bin/source/.env
#     sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=$(openssl rand -base64 32)|g" $out/bin/source/.env
#     sed -i "s|REDIS_PASSWORD=.*|REDIS_PASSWORD=$(openssl rand -base64 32)|g" $out/bin/source/.env
#     sed -i "s|PUSHER_APP_ID=.*|PUSHER_APP_ID=$(openssl rand -hex 32)|g" $out/bin/source/.env
#     sed -i "s|PUSHER_APP_KEY=.*|PUSHER_APP_KEY=$(openssl rand -hex 32)|g" $out/bin/source/.env
#     sed -i "s|PUSHER_APP_SECRET=.*|PUSHER_APP_SECRET=$(openssl rand -hex 32)|g" $out/bin/source/.env
#
#     ls ${src} > $out/bin/ls
#   '';
# }

