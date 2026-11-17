# Greenbone/OpenVAS — LAB RZC

> Registro da implantação e configuração realizada em outubro/2026. Sem senhas, tokens ou arquivos de ambiente neste repositório.

## Arquitetura

- Host: `RZ-DCK-SEC01`, Rocky Linux 9.8, endereço `172.16.240.222`.
- Compose oficial em `/srv/docker/security/greenbone/compose.yaml`; override separado.
- Interface HTTPS: `https://172.16.240.222:9443/`.
- Scanner `OpenVAS Default` validado por `Scanner Verified`.
- Serviços: `gvmd`, `pg-gvm`, `ospd-openvas`, `gsad` e `nginx`.
- Boot: `rz-greenbone.service` habilitado; recuperação após reboot e login web confirmados.

## Feeds e atualização

Foram carregados 190.916 NVTs; NVT/CERT/GVMD_DATA apresentavam status `Current` e o SCAP `3 days old` na última captura de 23/10/2026.

A rotina instalada no Rocky usa:
- `/usr/local/sbin/rz-greenbone-feeds.sh`.
- `rz-greenbone-feeds.service` com acionamento por `rz-greenbone-feeds.timer`.
- Agenda: **sexta-feira, às 09h, America/Sao_Paulo**, `Persistent=false`.
- Timer habilitado e ativo, mas **primeira execução efetiva não validada**.
- Imagens de dados: `notus-data`, `vulnerability-tests`, `scap-data`, `dfn-cert-data`, `cert-bund-data`, `report-formats` e `data-objects`.

## Regras de escopo

A sub-rede `172.16.240.0/24` é compartilhada. Endereços `.1–.60` são residenciais e ficam **fora de varreduras gerais**. A faixa autorizada do LAB é `172.16.240.61–254`.

| Target | Endereços | Uso |
|---|---|---|
| `LAB-RZC-LAB-DISCOVERY` | `.61–.254` (194 IPs) | Descoberta geral |
| `LAB-RZC-LAB-FULL` | `.61–.254` excluindo seis IPs (188) | Vulnerabilidades gerais |
| `LAB-RZC-LAB-CRITICAL` | `.98, .99, .121, .201, .221, .222` | Ativos críticos |
| `LAB-RZC-NETWORK` | `.1, .17, .22, .29, .30` | FortiGate, APs, switch — avaliação separada |
| `LAB-RZC-IDRAC` | `.38, .39` | iDRACs, segundo possivelmente desligado |
| `LAB-RZC-REDE-172.16.240` | `/24` | Apenas histórico: **não executar novamente** |

Exclusões do FULL: `172.16.240.98,172.16.240.99,172.16.240.121,172.16.240.201,172.16.240.221,172.16.240.222`. O `.99` é ESXi, não iDRAC.

## Tasks

| Task | Tipo | Target | Concorrência | Agenda |
|---|---|---|---|---|
| `LAB-RZC-DISCOVERY` | Host Discovery | LAB-DISCOVERY | 2 hosts / 2 NVTs | Semanal |
| `LAB-RZC-FULL-SCAN` | Full and fast | LAB-FULL | 2 hosts / 2 NVTs | Manual |
| `LAB-RZC-CRITICAL-SCAN` | Full and fast | LAB-CRITICAL | 1 host / 2 NVTs | Manual |
| `LAB-RZC-NETWORK-DISCOVERY` | Host Discovery | NETWORK | 1 host / 1 NVT | Manual |
| `LAB-RZC-IDRAC-DISCOVERY` | Host Discovery | IDRAC | 1 host / 1 NVT | Manual |

Schedule `LAB-RZC-DISCOVERY-SEMANAL`: **sábado às 14h, America/Sao_Paulo (17h UTC)**, deliberadamente escolhido e vinculado à Task de descoberta. Scanner padrão `OpenVAS Default`, mínimo de QoD 70%.

Resultados históricos antes do ajuste de escopo: descoberta de 21 hosts; System Discovery de 20 hosts; tarefa Full and fast com 23 hosts, 521 resultados e 20 mensagens de erro. Esses números não significam 521 vulnerabilidades distintas. Não repetir scans antigos que englobem a rede residencial.

## Verificação (somente leitura)

```bash
cd /srv/docker/security/greenbone
docker compose config --quiet
docker compose ps gvmd pg-gvm ospd-openvas gsad nginx
systemctl is-active rz-greenbone.service
systemctl list-timers --all rz-greenbone-feeds.timer
journalctl -u rz-greenbone-feeds.service -n 30 --no-pager
df -hT /var/lib/docker
```

## Pendências

- Validar execução real do timer de atualização dos feeds.
- Confirmar primeiro agendamento de descoberta.
- Configurar exportação de relatórios e integração com DefectDojo.
- Testar backup e restauração dos volumes/banco.
- Rotacionar a senha administrativa exposta anteriormente em captura.
- Remediação de vulnerabilidades e hardening: **em outra conversa**, após o término da configuração das ferramentas.

**Decisão:** manter Greenbone sem credenciais SSH/SMB por enquanto; Wazuh realizará a coleta interna dos endpoints via agentes.
