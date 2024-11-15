To-Do List App
Este é um aplicativo de lista de tarefas desenvolvido com Flutter, que se comunica com uma API construída em Laravel para o gerenciamento de dados (CRUD). O objetivo do projeto é permitir que o usuário crie, visualize, edite e exclua tarefas de forma simples e eficiente.

🛠 Tecnologias Utilizadas
Flutter: Framework para o desenvolvimento de aplicativos móveis multiplataforma (Android e iOS).
Dart: Linguagem de programação utilizada no desenvolvimento do aplicativo.
Provider: Gerenciador de estado que facilita a comunicação entre os widgets.
HTTP: Biblioteca para realizar requisições HTTP e interagir com a API.
Laravel: Framework PHP utilizado para construir a API RESTful que manipula as tarefas.
🚀 Funcionalidades
Listagem de Tarefas: Visualize todas as tarefas cadastradas, com título e descrição.
Adicionar Tarefa: Crie novas tarefas, definindo um título e descrição.
Editar Tarefa: Modifique as informações de tarefas já cadastradas.
Excluir Tarefa: Remova tarefas que não são mais necessárias.
Indicador de Carregamento: Durante o carregamento das tarefas, é exibido um indicador de progresso para o usuário.
📂 Estrutura do Projeto
/lib: Diretório principal que contém todos os arquivos do Flutter.
/models: Define o modelo Task, que representa uma tarefa.
/providers: Contém o TaskProvider, responsável por gerenciar o estado e realizar as operações de CRUD.
/services: Inclui o ApiService, que faz a comunicação com a API em Laravel.
/screens: Armazena a tela principal (HomeScreen), onde as tarefas são exibidas e manipuladas.
/assets: (opcional) Diretório para recursos como ícones e imagens, se necessário.
⚙️ Como Rodar o Projeto
Clone o repositório:

Abra o terminal e execute o comando abaixo para clonar o repositório:

bash
Copiar código
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
Instale as dependências do Flutter:

Certifique-se de que o Flutter esteja instalado corretamente em seu ambiente. Em seguida, rode o comando para instalar as dependências do projeto:

bash
Copiar código
flutter pub get
Configure a API (Back-end Laravel):

Se ainda não tiver configurado a API, siga as instruções no repositório da API para configurar o ambiente, criar o banco de dados e rodar as migrations necessárias.

Execute o aplicativo Flutter:

Conecte um dispositivo Android/iOS ou use o emulador e execute o aplicativo com o comando:

bash
Copiar código
flutter run
Testando Funcionalidades:

Carregar Tarefas: Ao abrir o aplicativo, as tarefas serão carregadas automaticamente da API.
Adicionar Tarefa: Clique no botão para adicionar uma nova tarefa, fornecendo o título e a descrição.
Editar ou Excluir Tarefa: Selecione uma tarefa para editá-la ou excluí-la utilizando o ícone de lixeira.
🔄 Melhorias Futuras
Implementar autenticação para controlar o acesso e segurança das tarefas.
Melhorar a interface com designs mais modernos e amigáveis.
Adicionar funcionalidades de notificações para lembrar o usuário sobre tarefas pendentes.
Incluir filtros e ordenação para tornar a visualização das tarefas mais prática.
