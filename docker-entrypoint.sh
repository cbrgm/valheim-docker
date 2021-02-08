#!/bin/sh
echo "VALHEIM DOCKER - DEDICATED GAMESERVER"
echo "https://www.valheimgame.com/"
echo ""
DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "Initalizing Docker container..."

check_files_exist() {
  FILE="./server/valheim_server.x86_64"
  if [ -f "$FILE" ]; then
    return 0;
  else
    return 1;
  fi
}

update_files() {
  steamcmd +login anonymous +force_install_dir /home/valheim/server +app_update 896660 +quit
}

if ! check_files_exist; then
  echo "Initalizing: Downloading Valheim server files for the first time, this may take a moment..."
  update_files
  echo "Done!"
else
  if [ ${UPDATE_ON_RESTART} -neq 0 ]; then
    echo "Checking for latest Valheim server updates, this may take a moment..."
    update_files
    echo "Done!"
  fi
fi

exec "$@"
