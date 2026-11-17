#!/usr/bin/env bash
# LAB RZC — cópia documental do script instalado no RZ-DCK-SEC01 em 23/10/2026.
# Requer Docker Compose e flock. O timer está ativo, mas a execução real ainda deve ser validada.
set -Eeuo pipefail

exec 9>/run/lock/rz-greenbone-feeds.lock
flock -n 9 || {
    echo "Atualizacao de feeds ja em andamento."
    exit 0
}

cd /srv/docker/security/greenbone

FEEDS=(
    notus-data
    vulnerability-tests
    scap-data
    dfn-cert-data
    cert-bund-data
    report-formats
    data-objects
)

echo "=== INICIO DA ATUALIZACAO DOS FEEDS ==="
date

/usr/bin/docker compose --parallel 1 pull "${FEEDS[@]}"

/usr/bin/docker compose up -d \
    --pull never \
    --no-build \
    "${FEEDS[@]}"

echo "=== IMAGENS E VOLUMES ATUALIZADOS ==="
echo "A importacao pelo GVMD/OpenVAS continua automaticamente."
date
