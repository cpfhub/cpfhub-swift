# cpfhub: Swift SDK for CPFHub.io

🇺🇸 **English** | [🇧🇷 Português](#português)

**Official Swift SDK for [CPFHub.io](https://cpfhub.io) — Brazilian CPF Lookup API**

[![Swift Package Index](https://img.shields.io/badge/SPM-compatible-brightgreen)](https://swiftpackageindex.com/cpfhub/cpfhub-swift)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

**Platforms:** iOS 15+ · macOS 12+ · watchOS 8+ · tvOS 15+

---

## What is CPFHub.io?

CPFHub.io is a REST API that returns name, gender, and date of birth from any Brazilian CPF number — in ~300ms, with 99.9% uptime and full LGPD compliance.

**10M+ CPFs queried · 1,300+ active companies · 99.9% uptime**

---

## Installation

**Swift Package Manager:**

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/cpfhub/cpfhub-swift.git", from: "1.0.0")
]
```

Or add via Xcode: **File → Add Package Dependencies** and enter the repository URL.

---

## Quick Start

```swift
import CPFHub

let client = CPFHubClient(apiKey: "YOUR_API_KEY")

Task {
    do {
        let result = try await client.lookup(cpf: "00000000000")
        print(result.name)      // "Fulano de Tal"
        print(result.gender)    // "M"
        print(result.birthDate) // "15/06/1990"
    } catch {
        print("Error: \(error)")
    }
}
```

Get your free API key at [app.cpfhub.io](https://app.cpfhub.io) — no credit card required.

---

## curl Example

```bash
curl -X GET "https://api.cpfhub.io/cpf/12345678909" \\
  -H "x-api-key: YOUR_API_KEY"
```

**Response:**

```json
{
  "success": true,
  "data": {
    "cpf": "12345678909",
    "name": "Fulano de Tal",
    "nameUpper": "FULANO DE TAL",
    "gender": "M",
    "birthDate": "15/06/1990",
    "day": 15,
    "month": 6,
    "year": 1990
  }
}
```

---

## API Reference

### `CPFHubClient(apiKey: String, timeout: TimeInterval = 10)`

### `client.lookup(cpf: String) async throws -> CPFResult`

Looks up a CPF and returns the associated identity data.

Accepts CPF with or without formatting (`000.000.000-00` or `00000000000`).

#### `CPFResult` properties

| Property | Type | Description |
|----------|------|-------------|
| `cpf` | `String` | CPF number (digits only) |
| `name` | `String` | Full name |
| `nameUpper` | `String` | Full name in uppercase |
| `gender` | `String` | `"M"` or `"F"` |
| `birthDate` | `String` | Date of birth — `"DD/MM/YYYY"` |
| `day` | `Int` | Birth day |
| `month` | `Int` | Birth month |
| `year` | `Int` | Birth year |

---

## Error Handling

```swift
do {
    let result = try await client.lookup(cpf: "00000000000")
    print(result.name)
} catch CPFHubError.invalidCPF {
    print("Invalid CPF format")       // 400
} catch CPFHubError.unauthorized {
    print("Invalid or missing API key") // 401
} catch CPFHubError.notFound {
    print("CPF not found")             // 404
} catch CPFHubError.rateLimitExceeded {
    print("Rate limit exceeded")     // 429
} catch {
    print("Error: \(error)")
}
```

---

## Examples

### SwiftUI onboarding

```swift
import SwiftUI
import CPFHub

struct OnboardingView: View {
    @State private var name = ""
    let client = CPFHubClient(apiKey: ProcessInfo.processInfo.environment["CPFHUB_API_KEY"] ?? "")

    func verify(cpf: String) async {
        if let result = try? await client.lookup(cpf: cpf) {
            name = result.name
        }
    }

    var body: some View {
        Text(name.isEmpty ? "Enter CPF" : "Welcome, \(name)")
    }
}
```

---

## Rate Limits

| Plan | Limit |
|------|-------|
| Free | 1 request every 2 seconds · 50 requests/month |
| Pro | 1 request per second · 1,000 requests/month |
| Corporate | Custom |

---

## Plans & Pricing

| Plan | Price | Included | Extra |
|------|-------|----------|-------|
| **Free** | R$ 0/month | 50 lookups | — |
| **Pro** | R$ 149/month | 1,000 lookups | R$ 0,15/lookup |
| **Corporate** | Custom | Custom | Custom |

[View full pricing at cpfhub.io →](https://cpfhub.io#pricing)

---

## Requirements

- Swift 5.7+
- iOS 15+ / macOS 12+ / watchOS 8+ / tvOS 15+

---

## Links

- [Documentation](https://cpfhub.io/documentacao)
- [Swift Package Index](https://swiftpackageindex.com/cpfhub/cpfhub-swift)
- [Dashboard](https://app.cpfhub.io)
- [Status Page](https://app.cpfhub.io/status)
- [Pricing](https://cpfhub.io#pricing)
- [LGPD Compliance](https://cpfhub.io/lgpd)
- [OpenAPI Specification](https://github.com/cpfhub/cpfhub-openapi/blob/main/openapi.yaml)
- [MCP Server (AI Agents)](https://github.com/cpfhub/cpfhub-mcp)

---

## License

MIT © [CPFHub.io](https://cpfhub.io)

---

# Português

[🇺🇸 English](#cpfhub-swift-sdk-for-cpfhubio) | 🇧🇷 **Português**

**SDK Swift oficial para [CPFHub.io](https://cpfhub.io) — API de Consulta de CPF Brasileiro**

**Plataformas:** iOS 15+ · macOS 12+ · watchOS 8+ · tvOS 15+

---

## O que é o CPFHub.io?

O CPFHub.io é uma API REST que retorna nome, gênero e data de nascimento de qualquer CPF brasileiro — em ~300ms, com 99,9% de uptime e total conformidade com a LGPD.

**10M+ CPFs consultados · 1.300+ empresas ativas · 99,9% uptime**

---

## Instalação

**Swift Package Manager:**

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/cpfhub/cpfhub-swift.git", from: "1.0.0")
]
```

Ou adicione via Xcode: **File → Add Package Dependencies** e insira a URL do repositório.

---

## Início Rápido

```swift
import CPFHub

let client = CPFHubClient(apiKey: "SUA_CHAVE_DE_API")

Task {
    do {
        let result = try await client.lookup(cpf: "00000000000")
        print(result.name)      // "Fulano de Tal"
        print(result.gender)    // "M"
        print(result.birthDate) // "15/06/1990"
    } catch {
        print("Erro: \(error)")
    }
}
```

Obtenha sua chave de API gratuita em [app.cpfhub.io](https://app.cpfhub.io) — sem cartão de crédito.

---

## Exemplo curl

```bash
curl -X GET "https://api.cpfhub.io/cpf/12345678909" \\
  -H "x-api-key: SUA_CHAVE_DE_API"
```

**Resposta:**

```json
{
  "success": true,
  "data": {
    "cpf": "12345678909",
    "name": "Fulano de Tal",
    "nameUpper": "FULANO DE TAL",
    "gender": "M",
    "birthDate": "15/06/1990",
    "day": 15,
    "month": 6,
    "year": 1990
  }
}
```

---

## Referência da API

### `CPFHubClient(apiKey: String, timeout: TimeInterval = 10)`

### `client.lookup(cpf: String) async throws -> CPFResult`

Consulta um CPF e retorna os dados de identidade associados.

Aceita CPF com ou sem formatação (`000.000.000-00` ou `00000000000`).

#### Propriedades de `CPFResult`

| Propriedade | Tipo | Descrição |
|-------------|------|----------|
| `cpf` | `String` | CPF (apenas dígitos) |
| `name` | `String` | Nome completo |
| `nameUpper` | `String` | Nome completo em maiúsculas |
| `gender` | `String` | `"M"` ou `"F"` |
| `birthDate` | `String` | Data de nascimento — `"DD/MM/YYYY"` |
| `day` | `Int` | Dia de nascimento |
| `month` | `Int` | Mês de nascimento |
| `year` | `Int` | Ano de nascimento |

---

## Tratamento de Erros

```swift
do {
    let result = try await client.lookup(cpf: "00000000000")
    print(result.name)
} catch CPFHubError.invalidCPF {
    print("Formato de CPF inválido")       // 400
} catch CPFHubError.unauthorized {
    print("Chave de API inválida ou ausente") // 401
} catch CPFHubError.notFound {
    print("CPF não encontrado")             // 404
} catch CPFHubError.rateLimitExceeded {
    print("Limite de requisições excedido")     // 429
} catch {
    print("Erro: \(error)")
}
```

---

## Exemplos

### Onboarding SwiftUI

```swift
import SwiftUI
import CPFHub

struct OnboardingView: View {
    @State private var name = ""
    let client = CPFHubClient(apiKey: ProcessInfo.processInfo.environment["CPFHUB_API_KEY"] ?? "")

    func verify(cpf: String) async {
        if let result = try? await client.lookup(cpf: cpf) {
            name = result.name
        }
    }

    var body: some View {
        Text(name.isEmpty ? "Digite o CPF" : "Bem-vindo, \(name)")
    }
}
```

---

## Limites de Requisição

| Plano | Limite |
|-------|--------|
| Gratuito | 1 requisição a cada 2 segundos · 50 requisições/mês |
| Pro | 1 requisição por segundo · 1.000 requisições/mês |
| Corporativo | Personalizado |

---

## Planos e Preços

| Plano | Preço | Incluído | Extra |
|-------|-------|----------|-------|
| **Gratuito** | R$ 0/mês | 50 consultas | — |
| **Pro** | R$ 149/mês | 1.000 consultas | R$ 0,15/consulta |
| **Corporativo** | Personalizado | Personalizado | Personalizado |

[Ver preços completos em cpfhub.io →](https://cpfhub.io#pricing)

---

## Requisitos

- Swift 5.7+
- iOS 15+ / macOS 12+ / watchOS 8+ / tvOS 15+

---

## Links

- [Documentação](https://cpfhub.io/documentacao)
- [Swift Package Index](https://swiftpackageindex.com/cpfhub/cpfhub-swift)
- [Dashboard](https://app.cpfhub.io)
- [Página de Status](https://app.cpfhub.io/status)
- [Preços](https://cpfhub.io#pricing)
- [Conformidade LGPD](https://cpfhub.io/lgpd)
- [Especificação OpenAPI](https://github.com/cpfhub/cpfhub-openapi/blob/main/openapi.yaml)
- [Servidor MCP (Agentes de IA)](https://github.com/cpfhub/cpfhub-mcp)

---

## Licença

MIT © [CPFHub.io](https://cpfhub.io)
