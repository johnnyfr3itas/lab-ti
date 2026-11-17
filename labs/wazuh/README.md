# Wazuh 4.14.9 — LAB RZC

## Finalidade

SIEM e monitoramento local de segurança: agentes Windows/Linux, logs, integridade de arquivos (FIM), Security Configuration Assessment (SCA), inventário e vulnerabilidades relacionadas a pacotes. Complementa a visão externa do Greenbone.

## Implantação observada

- Stack oficial single-node em `/srv/docker/security/wazuh/single-node`.
- Serviços Docker: `wazuh.manager`, `wazuh.indexer`, `wazuh.dashboard`.
- Dashboard em `https://172.16.240.222/` (host 443 → container 5601).
- Agentes: host `172.16.240.222`, portas `1514/1515 TCP`.
- Indexer 9200 e API Manager 55000 não publicados externamente.
- Certificados e credenciais da stack protegidos localmente; não armazenar no Git.
- Configuração `vm.max_map_count=262144` aplicada.
- Containers recuperados automaticamente após reboot; interface HTTP 302.

## Agente local

| Campo | Valor |
|---|---|
| Host | `RZ-DCK-SEC01` |
| Agent ID | `001` |
| Versão | 4.14.9 |
| Manager | `172.16.240.222` |
| Estado validado | `Active` no Manager e `connected` no host |

O Dashboard mostrou inventário, controles CIS Rocky Linux 9 e achados de vulnerabilidades. Esses achados foram **apenas registrados**, sem correção.

### Comandos somente leitura

```bash
systemctl is-active wazuh-agent
grep '^status=' /var/ossec/var/run/wazuh-agentd.state
cd /srv/docker/security/wazuh/single-node
docker compose ps
docker compose exec -T wazuh.manager /var/ossec/bin/agent_control -l
```

## Próximas atividades

- Criar grupos para Linux Servers, Windows Servers e Windows Workstations.
- Instalar agentes nos membros reais do LAB e validar inventário, eventos, SCA e FIM.
- Ajustar retenção, monitoramento e notificações conforme recursos disponíveis.
- Integrar ao DefectDojo apenas achados relevantes, não todos os eventos SIEM.
- Tratar vulnerabilidades e hardening em outra etapa.
