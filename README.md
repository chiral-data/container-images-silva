# container-images-silva

## Container Images

Application container images are hosted on our private registry at `chiral.sakuracr.jp`.
To pull a specific application image, use the following format:

```bash
docker pull chiral.sakuracr.jp:/<app_name>:<date_tag>
```

Where:

- `<app_name>`: The name of the application (e.g., `boltz`, `gromacs`).
- `<date_tag>`: The version or date-based tag for the image. This typically represents a specific build on that day.
  The latest `date_tag` is `2025_09_05`.
  **Example:** To pull the `gromacs` application image using the current tag:

```bash
docker pull chiral.sakuracr.jp:/gromacs:2025_09_05
```
