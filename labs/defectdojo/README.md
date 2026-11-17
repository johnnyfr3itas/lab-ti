# DefectDojo Community 3.4.202 — LAB RZC

## Propósito

Plataforma de gestão de vulnerabilidades: consolida relatórios importados, mantém produtos e engajamentos, permite organizar achados e acompanhar seu ciclo de vida. Não é scanner, SIEM nem ferramenta de remediação.

## Implantação registrada

- Código oficial clonado na tag `3.4.202` em `/srv/docker/security/defectdojo`.
- Docker Compose com `postgres`, `valkey`, `initializer`, `uwsgi`, `celeryworker`, `celerybeat` e `nginx`.
- Interface em `https://172.16.240.222:8443/`, sem publicação da porta HTTP 8080.
- Credenciais e chaves em arquivo local `.env` com permissão 0600; não publicar.
- Serviços persistentes: `restart: unless-stopped`; `initializer` termina `Exited (0)`.
- Banco PostgreSQL 18: `PGDATA=/var/lib/postgresql/data`, com `PG_VERSION=18` validado depois do reboot.
- Login administrativo e retomada da interface após reboot validados (HTTP 302).

## Verificações

```bash
cd /srv/docker/security/defectdojo
docker compose ps -a
docker exec defectdojo-postgres-1 sh -c 'echo "$PGDATA"; test -f "$PGDATA/PG_VERSION" && cat "$PGDATA/PG_VERSION"'
curl -k -sS -o /dev/null -w '%{http_code}\n' https://172.16.240.222:8443/
```

**Cuidado:** `docker compose config` sem filtros pode expor variáveis de ambiente e credenciais.

## Integração planejada

1. Criar estrutura de Products, Engagements e Tests do LAB.
2. Importar e reimportar relatórios do Greenbone pelos formatos/parsers compatíveis com a edição Community.
3. Avaliar fluxo separado de achados Wazuh, sem importar todos os alertas e logs.
4. Automatizar importações pela API com token próprio e controles de acesso.
5. Realizar backup/restauração consistente do PostgreSQL e dos volumes.

**Estado:** plataforma instalada e acessível; integração com scanners ainda não validada. Tratativa de vulnerabilidades será em outro chat.
