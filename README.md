# Multi-Architecture Docker Image Build Example

This repository demonstrates how to build and publish multi-architecture Docker images to GitHub Container Registry (ghcr.io) using GitHub Actions. The workflow builds images for both x64 and ARM64 architectures and creates a manifest list for seamless multi-arch support.

## Workflow Overview

The GitHub Actions workflow consists of two main jobs:

1. `build_and_push`: Builds architecture-specific images
   - Runs on both `ubuntu-24.04` (x64) and `ubuntu-24.04-arm` (ARM64) runners
   - Builds and pushes individual architecture images

2. `build_manifest_and_push`: Creates a multi-arch manifest
   - Combines the architecture-specific images
   - Creates and pushes a manifest list for transparent multi-arch support

## Prerequisites

- GitHub repository with access to GitHub Actions
- Permission to publish packages to GitHub Container Registry
- Docker installed (for local testing)

## Usage

### GitHub Actions Workflow

The workflow can be triggered manually through the GitHub Actions UI using the `workflow_dispatch` event.

### Required Permissions

The workflow requires the following permissions:
- `contents: read`
- `packages: write`
- `id-token: write`

### Environment Variables

- `OCI_REGISTRY`: Set to `ghcr.io` for GitHub Container Registry

## Image Tags

The workflow creates the following tags:
- `<registry>/<repository>/testuvimage:X64` - x64 architecture image
- `<registry>/<repository>/testuvimage:ARM64` - ARM64 architecture image
- `<registry>/<repository>/testuvimage:latest` - Multi-arch manifest list

## Local Testing

To pull and run the multi-arch image locally:

```bash
docker pull ghcr.io/<your-username>/<repository>/testuvimage:latest
docker run ghcr.io/<your-username>/<repository>/testuvimage:latest
```

Docker will automatically select the appropriate architecture for your system.

## Implementation Details

### Build Job
```yaml
build_and_push:
  runs-on: ${{ matrix.os }}
  strategy:
    matrix:
      os: [ubuntu-24.04, ubuntu-24.04-arm]
```

This job builds architecture-specific images using GitHub's Ubuntu runners for both x64 and ARM64 architectures.

### Manifest Creation
```yaml
build_manifest_and_push:
  needs: [build_and_push]
  runs-on: ubuntu-24.04
```

This job creates a manifest list that combines both architecture images into a single reference.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
