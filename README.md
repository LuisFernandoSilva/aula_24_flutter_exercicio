# aula_24_flutter_exercicio

Bom, já que aprendemos sobre banco de dados e vimos que não é algo tão simples assim, vamos fazer uma atividade para exercitar.

Vamos fazer um app que já fizemos em aulas passadas, vamos fazer um ToDo List (Uma lista de tarefas)

Para esse app, vamos ter somente uma tela que vai conter:

- 1 Um TextField para o nome da tarefa
- 2 Um botão para incluir a tarefa no banco de dados
- 3 Uma lista para mostrar tarefas cadastradas no banco de dados.
- 3.1 Cada item da lista precisa ter o nome da tarefa e um checkbox para informar se a tarefa está concluída ou não.

Além desses widgets no layout, o app precisa ter um banco de dados, com uma tabela chamada "tarefas" com as seguintes colunas: id (INTEGER PRIMARY KEY AUTOINCREMENT), nome (TEXT), concluido (INTEGER).

As funcionalidades do app são:

A lista de tarefas precisam ser carregadas do banco de dados
Ao clicar no botão "adicionar" a tarefa deve ser adicionada  no banco de dados
Ao fazer um clique longo nos itens da lista, o item deve ser excluído do banco de dados.
Ao clicar no checkbox da tarefa deve concluir a tarefa caso ela não esteja concluída ou deve marcar como não concluída caso ela esteja concluída e atualizar no banco de dados (FUNCIONALIDADE DESAFIO) 
