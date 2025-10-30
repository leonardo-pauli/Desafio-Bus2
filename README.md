# Desafio Flutter Pleno - Bus2

Este projeto é a minha solução para o Desafio Técnico de Desenvolvedor(a) Flutter. O aplicativo consome a API `randomuser.me` para exibir, salvar e gerenciar perfis de usuários.

## 🚀 Requisitos Técnicos Atendidos

O projeto foi construído seguindo rigorosamente todos os requisitos obrigatórios:

* **Arquitetura:** MVVM (usando Cubit como ViewModel)
* **Padrão de Dados:** Repository Strategy
* **Persistência:** SQflite (DatabaseHelper + CRUD)
* **Modelagem:** Parseamento de JSON para Modelo Dart (`UserModel`) e conversão para Modelo de Persistência (`UserDbModel`).
* **Funcionalidade Chave:** `Ticker` (não `Timer`) para atualizações de 5 segundos na tela inicial.
* **Telas:** 3 telas (Home, Detalhes, Usuários Salvos) com a navegação exigida.
* **Princípios:** Orientação a Objetos.

## 💡 Decisões de Projeto e Arquitetura

Para este desafio, tomei as seguintes decisões técnicas:

1.  **Gerenciamento de Estado (ViewModel):**
    * **Escolha:** `flutter_bloc` (Cubit).
    * **Justificativa:** O Cubit se encaixa perfeitamente no papel de ViewModel do padrão MVVM. Ele permite que a View (Widget) chame funções diretas (ex: `loadUsers()`) e reaja a mudanças de Estado (ex: `HomeLoaded`), mantendo o código limpo, reativo e de maneira mais simples que o BLoC.

2.  **Persistência (Repository):**
    * **Escolha:** `sqflite`.
    * **Justificativa:** Em vez de uma solução NoSQL mais simples como `hive`, optei por `sqflite` para demonstrar proficiência em um banco relacional, incluindo a criação de *schema* SQL, gerenciamento de banco (Singleton `DatabaseHelper`) e mapeamento de dados (CRUD).

3.  **Robustez e UX (Aprimoramentos):**
    * **Pull-to-Refresh:** Implementado em ambas as listas (`HomeScreen` e `SavedUsersScreen`).
    * **Feedback de Ação:** O app notifica o usuário com um `SnackBar` em caso de falha ao salvar/remover um usuário (evitando "falhas silenciosas").
    * **Feedback de Erro:** Telas de erro e estado vazio possuem um botão "Tentar Novamente", melhorando a usabilidade.

### ⚠️ Nota sobre Ambiguidade de Requisitos

Percebi uma ambiguidade nos requisitos do desafio:

* `` (Tela Inicial) instruía o **auto-save** de todos os usuários buscados pela API.
* `` (Tela de Detalhes) instruía um **botão para salvar manualmente**.

**Minha Decisão:** Segui o requisito `` literalmente. O `HomeCubit` persiste automaticamente cada novo usuário no `sqflite`. Como resultado, o botão na `DetailsScreen` funciona primariamente como **Remover** e **Re-Salvar** um usuário que foi removido da persistência, garantindo que ambos os requisitos fossem atendidos de forma lógica.

## 🔧 Como Executar

1.  Clone o repositório.
2.  Rode `flutter pub get`.
3.  Execute o aplicativo: `flutter run`.
