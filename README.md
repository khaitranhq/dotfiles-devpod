# Dotfiles for DevPod

Build:

```bash
docker build -t devpod-local:go-latest --target go .
docker build -t devpod-local:cpp-latest --target fundamental .
```

Example `.devcontainer/devcontainer.json`:

```json
{
  "image": "devpod-local:latest"
}
```
