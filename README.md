# LAB TI - Laboratório de Infraestrutura e Segurança

Repositório para organizar os laboratórios práticos de TI com foco em:

- Virtualização
- Redes
- Segurança
- Monitoramento
- Infraestrutura
- Automação com scripts e Ansible

Cada pasta contém um cenário com documentação passo a passo, scripts e diagramas.

---

## Ambiente LAB RZC — Segurança (implantação 2026)

| Componente | Função | Documentação |
|---|---|---|
| RZ-DCK-SEC01 | Rocky Linux, Docker, persistência e serviços | [Host de segurança](labs/security/rz-dck-sec01.md) |
| Wazuh 4.14.9 | SIEM e agentes dos endpoints | [Wazuh](labs/wazuh/README.md) |
| Greenbone/OpenVAS | Descoberta e scans de rede | [Greenbone](labs/greenbone/README.md) |
| DefectDojo 3.4.202 | Gestão dos achados | [DefectDojo](labs/defectdojo/README.md) |

**Diretriz:** configurar e validar ferramentas antes de tratar vulnerabilidades. Faixa geral autorizada para scans: `172.16.240.61–254`; `.1–.60` é residencial, com inspeções específicas de infraestrutura em Targets separados.

## 📂 Índice de Labs

### 🧱 Infraestrutura
- [docs/infraestrutura.md](docs/infraestrutura.md)

### 🖥️ Virtualização
- [labs/proxmox/instalacao.md](labs/proxmox/instalacao.md)
- [labs/vmware/deploy-esxi.md](labs/vmware/deploy-esxi.md)
- [labs/hyperv/instalacao.md](labs/hyperv/instalacao.md)

### 🌐 Redes
- [docs/redes.md](docs/redes.md)
- [labs/nginx/reverse-proxy.md](labs/nginx/reverse-proxy.md)
- [labs/phpipam/instalacao.md](labs/phpipam/instalacao.md)

### 🔐 Segurança
- [docs/seguranca.md](docs/seguranca.md)
- [labs/security/rz-dck-sec01.md](labs/security/rz-dck-sec01.md)
- [labs/wazuh/README.md](labs/wazuh/README.md)
- [labs/greenbone/README.md](labs/greenbone/README.md)
- [labs/defectdojo/README.md](labs/defectdojo/README.md)
- [labs/jumpserver/README.md](labs/jumpserver/README.md)
- [labs/pfsense/configuracao-basica.md](labs/pfsense/configuracao-basica.md)
- [labs/fortigate/firewall-basico.md](labs/fortigate/firewall-basico.md)
- [labs/pihole/bloqueio-propagandas.md](labs/pihole/bloqueio-propagandas.md)

### 📊 Monitoramento
- [docs/monitoramento.md](docs/monitoramento.md)
- [labs/zabbix/monitoramento-vmware.md](labs/zabbix/monitoramento-vmware.md)
- [labs/grafana/dashboards.md](labs/grafana/dashboards.md)
- [labs/prometheus/configuracao.md](labs/prometheus/configuracao.md)

### 🐳 Docker & Scripts
- [labs/docker/lab-inicial.md](labs/docker/lab-inicial.md)
- [scripts/bash/rz-greenbone-feeds.sh](scripts/bash/rz-greenbone-feeds.sh)
- [scripts/ansible/setup.yml](scripts/ansible/setup.yml)
- [scripts/bash/backup.sh](scripts/bash/backup.sh)
- [scripts/powershell/coletar-logs.ps1](scripts/powershell/coletar-logs.ps1)

### 📐 Diagramas
- [diagrams/lab-rede.drawio](diagrams/lab-rede.drawio)
- [diagrams/arquitetura-proxmox.png](diagrams/arquitetura-proxmox.png)
