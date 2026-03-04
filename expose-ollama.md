# Expose ollama on the local network via IP

1\. Edit the systemd service by calling: `systemctl edit ollama.service`

2\. Add the following line under the [Service] section:

```ini
[Service]
Environment="OLLAMA_HOST=0.0.0.0:11434"
```

3\. Save and exit the editor.

4\. Reload systemd and restart Ollama:

```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

---

See source: https://atlassc.net/2024/10/24/how-to-share-ollama-server-through-ip-address-and-port
