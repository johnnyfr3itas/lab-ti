# Segurança — LAB RZC

A arquitetura usa ferramentas complementares, com configuração prática e validação por etapas.

| Ferramenta | Responsabilidade |
|---|---|
| **Greenbone/OpenVAS** | Descoberta, portas e serviços, vulnerabilidades remotamente identificáveis, inclusive ativos sem agente |
| **Wazuh** | SIEM, eventos, agentes Windows/Linux, inventário, CVEs de pacotes, SCA e FIM |
| **Zabbix** | Disponibilidade, desempenho, recursos, SNMP, interfaces de rede e containers (coleta Docker a configurar) |
| **DefectDojo** | Centralização de achados, produtos/engajamentos, ciclo de vida e relatórios, após integrações serem validadas |

## Organização

- [Host Rocky Linux e Docker RZ-DCK-SEC01](../labs/security/rz-dck-sec01.md)
- [Greenbone — Targets, Tasks, scans, feeds e cronogramas](../labs/greenbone/README.md)
- [Wazuh — instalação single-node e agente](../labs/wazuh/README.md)
- [DefectDojo — instalação e implantação](../labs/defectdojo/README.md)
- [JumpServer — PAM](../labs/jumpserver/README.md)

## Política de escopo e segurança

- Rede `172.16.240.0/24` compartilhada entre residência e LAB.
- Escopo **geral** de varreduras: `172.16.240.61–254`. IPs `.1–.60` não fazem parte dos scans gerais.
- FortiGate/APs/switch e iDRACs estão em Targets específicos para avaliações controladas.
- Target antigo de descoberta da rede inteira é histórico e não deve ser reexecutado.
- Privilegiar Targets por segmento e política, não um cadastro por máquina.
- Greenbone inicialmente sem credenciais SSH/SMB; Wazuh é o agente de segurança do endpoint.
- **Não realizar remediação, correção de CVEs ou hardening durante a fase atual de configuração.** Registre pendências para etapa separada.
- Nunca publicar senhas, chaves, tokens, dumps ou certificados privados no Git.

## Pendências

Atualização efetiva dos feeds Greenbone; relatórios e integração com DefectDojo; implantação de agentes Wazuh nas VMs; monitoramento Docker no Zabbix; backup/restauração dos bancos e volumes; rotação da senha Greenbone exposta em captura.

As informações documentam testes de outubro de 2026; não são garantia do estado atual sem nova verificação.
