sudo systemctl start ollama
if [ $1 = "llama" ]; then
  ollama run llama3:8b
else
  ollama run gpt-oss:20b
fi
sudo systemctl stop ollama
