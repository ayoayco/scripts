sudo systemctl start ollama
sleep 1


if ! [ "$2" = "" ]; then
  ollama run gpt-oss:20b "$2"
else
  ollama run gpt-oss:20b
fi
sudo systemctl stop ollama
