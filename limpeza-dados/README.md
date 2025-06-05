# 🧹 Script de Limpeza de Dados – Exemplo Genérico para ERP

Este script SQL demonstra um processo completo de limpeza de dados em um banco de dados relacional fictício. Ele simula ações comuns em sistemas ERP, como exclusão de registros órfãos, truncamento de tabelas e controle de gatilhos (triggers).

### 📋 O que este script faz:

- Remove registros inconsistentes ou inválidos com `DELETE`
- Trunca tabelas quando possível (`TRUNCATE TABLE`)
- Desabilita e reabilita triggers para evitar restrições durante a limpeza
- Segue uma ordem lógica baseada em dependências entre tabelas

### 📁 Arquivos

- `cleanup-script-generic-erp.sql` → Script SQL completo
- `LICENSE` → Licença MIT para uso livre
