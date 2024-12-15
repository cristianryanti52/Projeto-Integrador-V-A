# Projeto-Integrador-V-A
Projeto Integrador V-A - Desenvolvimento de um aplicativo com funcionalidades completas de CRUD (Criar, Ler, Atualizar e Excluir).

<h1>Documentação do Aplicativo de Contatos</h1>

<h2>Visão Geral</h2> 

Este aplicativo móvel em Flutter tem como objetivo gerenciar uma lista de contatos pessoais armazenados localmente. O usuário pode cadastrar novos contatos (contendo nome, telefone e e-mail), visualizar uma lista completa dos contatos cadastrados, editar as informações de um contato existente e excluí-lo definitivamente do banco de dados local. 

<h3>Tecnologias Utilizadas</h3> 

Linguagem: Dart 

Framework: Flutter 

Utilizado para criar a interface do usuário e gerenciar a navegação entre telas. O Flutter oferece um conjunto de widgets e ferramentas que permitem desenvolver interfaces responsivas e multiplataforma (Android/iOS) a partir de um único código-fonte. 

<h3>Banco de Dados Local: Hive</h3>  

O Hive é um banco de dados NoSQL local, rápido e leve, ideal para armazenar dados diretamente no dispositivo sem a necessidade de um servidor remoto. Ele não requer o uso de um FutureBuilder para a inicialização e oferece performance superior para operações CRUD locais. 

<h3>Gerenciador de Dependências: pubspec.yaml</h3>  

As dependências do projeto (Hive, hive_flutter, build_runner, hive_generator e outras) são configuradas no pubspec.yaml. O build_runner e o hive_generator são utilizados para gerar os adapters das classes de modelos, permitindo que o Hive serialize e deserialize os objetos de forma automática. 

<h3>Ambiente de Desenvolvimento: Windows + Visual Studio Code</h3>  

O desenvolvimento foi realizado em um ambiente Windows, utilizando o VSCode, que oferece ótima integração com Flutter através de extensões, linting, debugging e emuladores. 

<h3>Estrutura de Pastas e Arquivos</h3>  

<h4>lib/main.dart</h4>  

Inicializa o Flutter, o Hive e a box (contactsBox) para armazenamento dos contatos. 

Define o tema da aplicação (incluindo esquema de cores e tipografia). 

Aponta para a tela inicial (HomePage). 

<h4>lib/models/contact.dart</h4>  

Define a classe Contact com campos name, phone e email. 

Inclui as anotações Hive (@HiveType e @HiveField) para possibilitar a geração do adapter. 

Esta classe representa o modelo de dados que será persistido localmente. 

<h4>lib/pages/home_page.dart (Tela de Listagem)</h4>  

Exibe a lista de contatos cadastrados, obtidos da box do Hive. 

Ao clicar em um contato, o usuário navega para a tela de detalhes do contato. 

Contém um botão flutuante (FAB) para adicionar um novo contato. 

<h4>lib/pages/add_contact_page.dart (Tela de Cadastro)</h4> 

Fornece um formulário para inserir nome, telefone e e-mail de um novo contato. 

Ao salvar, o contato é adicionado ao Hive e o usuário retorna à tela de listagem. 

<h4>lib/pages/contact_details_page.dart (Tela de Detalhes)</h4>

Mostra informações completas do contato selecionado. 

Permite navegar para a edição do contato ou excluí-lo. 

Após edição, atualiza a exibição ao voltar, garantindo que os dados estejam sempre sincronizados com o Hive. 

<h4>lib/pages/edit_contact_page.dart (Tela de Edição)</h4> 

Permite alterar os dados de um contato já existente. 

Ao salvar, o contato é atualizado no Hive e o usuário volta à tela de detalhes, que é reconstruída para refletir as mudanças. 

<h3>Funcionalidades de CRUD</h3>  

<h4>Create (Criar)</h4> 

Na tela de cadastro (AddContactPage), o usuário preenche um formulário com nome, telefone e e-mail. Ao pressionar o botão "Salvar", esses dados são encapsulados em um objeto Contact e armazenados no Hive através do contactsBox.add(newContact). Isso insere um novo registro na base local. 

<h4>Read (Ler/Consultar)</h4> 

Na tela inicial (HomePage), um ValueListenableBuilder escuta a box do Hive, exibindo todos os contatos em uma lista. Ao selecionar um contato, o usuário é direcionado para a tela de detalhes (ContactDetailsPage), onde todas as informações do contato são exibidas. A leitura é feita de forma simples, usando final contact = box.getAt(index)!;. 

<h4>Update (Atualizar)</h4> 

Na tela de edição (EditContactPage), o usuário altera as informações do contato. Ao salvar, o registro correspondente no Hive é atualizado usando box.putAt(index, updatedContact). Ao retornar à tela de detalhes, um setState() é acionado, forçando a reconstrução e a exibição dos dados atualizados. 

<h4>Delete (Excluir)</h4> 

Na tela de detalhes do contato, um botão permite excluir o contato. Ao confirmar a exclusão, box.deleteAt(index) remove o contato do banco, atualizando automaticamente a interface na tela de listagem. Uma caixa de diálogo (AlertDialog) é usada para confirmar a intenção do usuário antes da remoção. 

<h3>Design Futurístico</h3> 

O tema da aplicação foi configurado para um visual "futurístico": 

<h4>Cores:</h4> 

Predomínio do tema escuro (brightness: Brightness.dark), com acentos em tealAccent e cyanAccent remetendo a um visual tecnológico. 

<h4>Tipografia:</h4> 

Fonte Roboto e ajuste nos estilos tipográficos da TextTheme para títulos e texto de corpo. 

Utilização do ColorScheme.fromSeed para gerar um conjunto coerente de cores de destaque. 

<h4>Componentes Visuais:</h4> 

Campos de texto com bordas arredondadas, fundo translúcido, ícones simples e um layout minimalista reforçam o aspecto futurista. 

<h3>Utilizando Extreme Programming (XP)</h3> 

O Extreme Programming (XP) é uma metodologia ágil que enfatiza o desenvolvimento iterativo, a comunicação constante, o feedback rápido e práticas de qualidade. Neste projeto, os seguintes aspectos do XP foram aplicados: 

<h4>Iterações Curtas:</h4> 

O projeto foi desenvolvido em ciclos curtos de entrega, focando primeiramente na funcionalidade de cadastro, depois na listagem, detalhes, edição e exclusão. Cada iteração agregou valor ao produto de forma incremental. 

<h4>Comunicação e Feedback Constante:</h4> 

Embora não retratado aqui literalmente, um cenário XP envolve o desenvolvedor mantendo comunicação direta e frequente com o cliente ou usuário final. Ao receber feedback sobre a usabilidade, foram feitas adaptações rápidas no design e nas telas, visando melhorar a experiência do usuário. 

<h4>Testes e Qualidade de Código:</h4>

O XP valoriza a qualidade. Embora o código apresentado não contenha testes automatizados completos, a abordagem XP incentivaria a criação de testes de widget e testes de unidade usando o pacote flutter_test. Esses testes garantiriam que cada parte do código estivesse funcionando conforme o esperado, resultando em menor retrabalho. 

Além disso, o uso de linting e a refatoração constante do código para mantê-lo limpo e legível seguem os princípios do XP. 

<h4>Refatoração Contínua:</h4> 

À medida que novas funcionalidades foram adicionadas, houve pequenos ajustes no código (como remover propriedades depreciadas, atualizar temas, melhorar a lógica de estado na tela de detalhes). Essa refatoração contínua evita a deterioração do código-fonte. 

<h4>Entrega Frequente e Incremental:</h4> 

Durante o desenvolvimento, cada etapa de implementação (CRUD) poderia ser demonstrada ao cliente, obtendo feedback antecipado. O XP incentiva a entrega frequente de pequenas funcionalidades utilizáveis em vez de um grande lançamento no final. 

<h3>Tela Inicial</h3>

![image](https://github.com/user-attachments/assets/2b5eca01-81ea-41c4-8401-8e3c31fb2682)

<h3>Tela de Formulário</h3>

![image](https://github.com/user-attachments/assets/fe13b171-5159-4da6-b9b5-e1a2aca9ea4c)

<h3>Tela de Contatos - após preenchimento do formulário</h3>

![image](https://github.com/user-attachments/assets/8e185261-d5e8-4104-84a7-7e76d7a2c907)

<h3>Tela de Edição/exclusão</h3>

![image](https://github.com/user-attachments/assets/5137d45e-e09d-4615-aef0-2e5c1a95bc20)

<h3>Tela de Mensagem - confirmação de exclusão</h3>

![image](https://github.com/user-attachments/assets/3d8e1c31-6898-4879-bb77-b4c0ca5ab1c0)


<h3>Conclusão</h3> 

A aplicação foi desenvolvida utilizando Flutter e Hive para oferecer uma experiência fluida de CRUD em um banco local. A estrutura de telas e navegação é clara e modular, permitindo fácil manutenção e extensões futuras. O design futurístico e as práticas do XP reforçam a qualidade do produto e a satisfação do usuário, garantindo evolução incremental e feedback rápido em todas as etapas do desenvolvimento. 

 
