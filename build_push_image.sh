#!/usr/bin/env bash

# Menghentikan script jika terjadi kesalahan
set -e

# Meminta username GitHub
read -r -p "GitHub username (lowercase): " GITHUB_USERNAME

# Meminta GitHub token secara tersembunyi
read -r -s -p "GitHub Personal Access Token: " GHCR_TOKEN
echo

# Build Docker image dengan nama item-app dan tag v1
docker build -t item-app:v1 .

# Menampilkan daftar image lokal
docker images

# Mengubah tag image sesuai format GitHub Container Registry
docker tag item-app:v1 ghcr.io/${GITHUB_USERNAME}/item-app:v1

# Login ke GitHub Container Registry
printf '%s' "$GHCR_TOKEN" | docker login ghcr.io \
  -u "$GITHUB_USERNAME" --password-stdin

# Menghapus token dari variabel
unset GHCR_TOKEN

# Push image ke GitHub Container Registry
docker push ghcr.io/${GITHUB_USERNAME}/item-app:v1
