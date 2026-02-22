# EstateHub App

Cliente Flutter da plataforma imobiliária EstateHub. Permite cadastrar, autenticar e gerenciar anúncios de imóveis, com suporte a múltiplos idiomas e temas.

> **Plataformas suportadas:** Android · iOS · macOS · Windows · Linux

---

## Dependência de Backend

**Esta aplicação não é standalone.** Toda a funcionalidade principal depende do serviço de backend [`estatehub_api`](../estatehub_api).

| Requisito | Detalhe |
|---|---|
| Serviço | `estatehub_api` (Go REST API) |
| URL base padrão | `http://localhost:8080/v1` |
| Health check | `GET /v1/health` → `200 OK` `"API Online!"` |

Consulte [Como Executar](#como-executar) para iniciar o backend antes do app.

---

## Funcionalidades

- **Cadastro e login** — tela inicial do app
- **Listagem de anúncios** — tela principal, com filtros (todos, meus anúncios, aluguel, venda) e busca por texto
- **Criar anúncio** — botão de adição na tela principal; suporta tipo, preço em BRL, endereço e foto da galeria
- **Consulta de CEP** — disponível no formulário de criação; preenche o endereço automaticamente
- **Cotação BRL → USD** — acessível pelo ícone de câmbio na tela principal
- **Excluir anúncio** — disponível em cada card de anúncio
- **Idioma e preferências** — tela de configurações, acessível pelo menu lateral
- **Tema claro/escuro** — segue a configuração do sistema operacional

---

## Arquitetura

O projeto segue **MVVM** com **Provider** para injeção de dependência e gerenciamento de estado. Operações assíncronas são encapsuladas em `Command<T>` e retornam `Result<T>` (sealed class com variantes `Success` e `Error`), eliminando tratamento implícito de nulos.

---

## Estrutura do Projeto

```
lib/src/
├── config/        # Providers (DI), localização (ARB + gerados)
├── core/          # Configuração do app, temas
├── data/          # ApiService, LocalStorage, modelos
├── routing/       # GoRouter
├── ui/
│   ├── core/      # Widgets e temas compartilhados
│   └── features/  # auth, home, property_ads, exchange_rates, settings, splash
└── utils/         # Result, Command, ErrorMapper, validadores
```

---

## Pré-requisitos

| Requisito | Versão |
|---|---|
| Dart SDK | `^3.10.7` |
| Flutter | Compatível com Dart `^3.10.7` |
| Docker + Docker Compose | Para executar o backend |

---

## Como Executar

### 1. Clonar o repositório

```bash
git clone <url-do-repositorio>
cd estatehub_api
```

### 2. Instalar dependências

```bash
flutter pub get
```

### 3. Configurar a URL da API

O arquivo `.env` na raiz do projeto aponta para o backend. O valor padrão é:

```
API_URL=http://localhost:8080/v1
```

Altere apenas se o backend estiver em um host ou porta diferente.

### 4. Iniciar o backend

```bash
cd ../estatehub_api
docker compose up --build
```

Aguarde até o servidor estar pronto. Para verificar:

```bash
curl http://localhost:8080/v1/health
# Resposta esperada: "API Online!"
```

### 5. Executar o app

```bash
# Dispositivo padrão
flutter run

# Plataforma específica
flutter run -d macos
flutter run -d windows
flutter run -d linux
flutter run -d <device-id>
```

---

## Testes

Os testes unitários cobrem repositórios e ViewModels das funcionalidades principais.

```bash
flutter test
```
