# RZ-DCK-SEC01 — Host de segurança do LAB RZC

> Inventário e validação realizados em outubro de 2026. Revalidar os serviços antes de manutenção.

## Inventário

| Item | Configuração |
|---|---|
| Host/IP | `RZ-DCK-SEC01` / `172.16.240.222/24` |
| Sistema operacional | Rocky Linux 9.8 |
| Virtualização | VMware ESXi |
| Recursos | 4 vCPU / 16 GiB RAM |
| Disco do SO | 60 GB |
| Disco Docker | 250 GB, XFS, montado em `/var/lib/docker` |
| Docker | Engine 29.9.2; Compose 5.6.1 (na implantação) |
| Segurança do host | SELinux Enforcing; firewalld ativo |

Os serviços Docker e containerd dependem do disco `/var/lib/docker`. Existe regra de `DOCKER-USER` restringindo novas conexões encaminhadas pela interface `ens34` provenientes de fora de `172.16.240.0/24`; isso não elimina a necessidade de segmentação de rede.

## Aplicações

| Serviço | Endereço | Validação após reboot |
|---|---|---|
| Wazuh | `https://172.16.240.222/` | HTTP 302 |
| Greenbone/OpenVAS | `https://172.16.240.222:9443/` | HTTP 200; login validado |
| DefectDojo | `https://172.16.240.222:8443/` | HTTP 302; login validado |
| Wazuh Agent | Manager `172.16.240.222:1514-1515/tcp` | Active/connected, agente 001 |
| Zabbix Agent 2 | `172.16.240.222:10050/tcp` | Agent ping 1; ZBX disponível |

## Organização

```text
/srv/docker/security/
├── wazuh/single-node/
├── greenbone/
└── defectdojo/
```

Wazuh utiliza três containers principais com reinício `always`. Greenbone é iniciado por `rz-greenbone.service`, que aplica `docker compose up -d --pull never --no-build` após o Docker. Os seis serviços persistentes do DefectDojo utilizam `unless-stopped`, enquanto `initializer` termina com `Exited (0)`. Os serviços de agentes Wazuh e Zabbix estão habilitados no systemd.

## Diagnóstico somente leitura

```bash
findmnt /var/lib/docker
systemctl is-active docker containerd wazuh-agent zabbix-agent2 rz-greenbone.service
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
docker system df
df -hT /var/lib/docker
free -h
```

## Continuidade e proteção

- Não versionar `.env`, senhas, tokens, certificados privados, chaves ou dumps.
- Fazer backups consistentes das bases PostgreSQL, do Wazuh Indexer, dos volumes e das configurações; testar restauração.
- Rotacionar a senha Greenbone que apareceu em captura anterior (pendente).
- Configurar monitoramento granular dos containers no Zabbix (pendente).
- Atualizar documentação quando houver evidência validada. Não realizar remediação de CVEs nesta fase.

Veja [Greenbone](../greenbone/README.md), [Wazuh](../wazuh/README.md) e [DefectDojo](../defectdojo/README.md).
