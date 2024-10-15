# 📝 Flutter To-Do List App

Este é um aplicativo simples de lista de tarefas (To-Do List) criado em Flutter. Ele permite que os usuários adicionem, excluam e organizem tarefas. O aplicativo também fornece uma interface visual agradável, com cores únicas atribuídas a cada tarefa.

## ✨ Funcionalidades
- **Adicionar tarefas**: Adicione novas tarefas à lista de maneira simples e rápida.
- **Excluir tarefas**: Remova tarefas da lista clicando no botão "X" ao lado de cada item.
- **Arrastar e soltar**: Reorganize as tarefas arrastando-as para a posição desejada.
- **Cores únicas**: Cada tarefa recebe uma cor aleatória para facilitar a visualização.

📂 Estrutura do Projeto
O projeto está organizado da seguinte forma:

```bash
lib/
│
├── main.dart        # Arquivo principal que inicializa o aplicativo
├── src/
│   ├── catalog.dart # Classe Catalog responsável por gerenciar a lista de tarefas
│   ├── item_tile.dart # Widget que representa visualmente cada item na lista
|   ├── api/
│   |  ├── item.dart    # Classe Item representando cada tarefa
```

### 📋 main.dart
Responsável por inicializar o aplicativo. Inclui a lógica para adicionar novas tarefas e exibir a lista de tarefas.

### 📋 catalog.dart
Gerencia a lista de tarefas. Ele armazena as tarefas e permite adicionar e remover itens.

### 📋 item_tile.dart
Responsável pela interface de cada tarefa na lista. Exibe o nome, a cor e um botão de exclusão para remover a tarefa.

### 📋 item.dart
Representa cada tarefa individualmente, contendo atributos como nome e cor.
