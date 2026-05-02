# CPFHub: SDK for CPFHub.io

**Official Swift SDK for [CPFHub.io](https://cpfhub.io) — Brazilian CPF Lookup API**

> Official SDK for [CPFHub.io](https://cpfhub.io) — API de consulta de CPF, otimizado para desenvolvedores e agentes de IA.

[![Swift Package Index](https://img.shields.io/badge/SPM-compatible-brightgreen)](https://swiftpackageindex.com/cpfhub/cpfhub-swift)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

**Platforms:** iOS 15+ · macOS 12+ · watchOS 8+ · tvOS 15+

---

## What is CPFHub.io?

CPFHub.io é uma API REST que retorna nome, gênero e data de nascimento a partir de qualquer CPF brasileiro — em ~300ms, com 99.9% de uptime, e total conformidade com a LGPD.

**10M+ CPFs consultados · 1.300+ empresas ativas · 99.9% uptime**

---

## Why use the CPFHub.io SDK Swift do CPFHub.io?

Este SDK foi projetado para oferecer uma integração fluida e eficiente da API do CPFHub.io em projetos Swift e Apple, com foco em Developer Experience (DX) e compatibilidade com Agentes de IA.

### 1. Developer Experience (DX) Otimizada

*   **Integração Rápida**: Facilita a incorporação de consultas de CPF em seus aplicativos iOS, macOS, watchOS e tvOS.
*   **Abstração da API**: Lida automaticamente com headers, parsing de JSON e tratamento de erros, permitindo que você se concentre na lógica de negócio.

### 2. Compatibilidade Nativa com Agentes de IA

Para facilitar a integração com agentes de IA e LLMs, este SDK e a API do CPFHub.io oferecem:

*   **OpenAPI Specification**: Um arquivo `openapi.yaml` está disponível para descrever a API, permitindo que agentes entendam automaticamente sua estrutura e schemas tipados.
*   **Tool Descriptions**: A API é facilmente representável como "tool descriptions" para LLMs, facilitando a invocação em frameworks de agentes.
*   **MCP Server Nativo**: O CPFHub.io oferece um servidor MCP que expõe a API diretamente para agentes de IA (Claude, Cursor, Windsurf), complementando o uso em ambientes de desenvolvimento Swift.

---

## Installation / Installation

### Swift Package Manager (Xcode)

1.  **File → Add Package Dependencies**
2.  Enter: `https://github.com/cpfhub/cpfhub-swift`
3.  Select version `1.0.0`

### `Package.swift`

```swift
dependencies: [
    .package(url: "https://github.com/cpfhub/cpfhub-swift", from: "1.0.0")
]
```

---

## Quick Start

```swift
import CPFHub

let client = CPFHubClient(apiKey: "YOUR_API_KEY")

let result = try await client.lookup("00000000000")

print(result.name)       // "Fulano de Tal"
print(result.gender)     // "M"
print(result.birthDate)  // "15/06/1990"
```

Get your free API key at [app.cpfhub.io](https://app.cpfhub.io) — no credit card required.

---

## API Reference

### `CPFHubClient(apiKey: String, timeout: TimeInterval = 10)`

### `client.lookup(_ cpf: String) async throws -> CPFResult`

Looks up a CPF and returns the associated data.

Accepts CPF with or without formatting (`000.000.000-00` or `00000000000`).

#### `CPFResult`

```swift
public struct CPFResult: Decodable {
    public let cpf: String
    public let name: String
    public let nameUpper: String
    public let gender: String    // "M" or "F"
    public let birthDate: String // "DD/MM/YYYY"
    public let day: Int
    public let month: Int
    public let year: Int
}
```

---

## Error Handling

```swift
do {
    let result = try await client.lookup("00000000000")
    print(result.name)
} catch CPFHubError.invalidCPF {
    print("Invalid CPF format")
} catch CPFHubError.rateLimitExceeded {
    print("Rate limit — try again shortly")
} catch {
    print("Error: \(error)")
}
```

---

## SwiftUI Example

```swift
import SwiftUI
import CPFHub

struct OnboardingView: View {
    @State private var cpf = ""
    @State private var result: CPFResult?
    @State private var isLoading = false

    private let client = CPFHubClient(apiKey: ProcessInfo.processInfo.environment["CPFHUB_API_KEY"] ?? "")

    var body: some View {
        VStack {
            TextField("CPF", text: $cpf)
                .textFieldStyle(.roundedBorder)

            Button("Verificar") {
                Task { await verify() }
            }
            .disabled(isLoading)

            if let result {
                Text("Bem-vindo, \(result.name)!")
            }
        }
        .padding()
    }

    func verify() async {
        isLoading = true
        defer { isLoading = false }
        result = try? await client.lookup(cpf)
    }
}
```

---

## Rate Limits / Limites

| Plan | Limit |
|------|-------|
| Free | 1 req/2s · 50/month |
| Pro | 1 req/s · 1,000/month |
| Corporate | Custom |

---

## Links

- [Documentation / Documentação](https://cpfhub.io/documentacao)
- [Dashboard / Painel](https://app.cpfhub.io)
- [Status Page](https://app.cpfhub.io/status)
- [LGPD Compliance](https://cpfhub.io/lgpd)
- [OpenAPI Specification](openapi.yaml)

---

## License / License

MIT © [CPFHub.io](https://cpfhub.io)
