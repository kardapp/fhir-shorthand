# fhir-shorthand

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/kardapp/fhir-shorthand)

Repo for health-informaticians to develop workflows with FHIR Shorthand instead of Forge FHIR test test

## Getting Started

### Using GitHub Codespaces

Click the badge above to open this repository in GitHub Codespaces. The development environment comes pre-configured with:

- **FHIR Shorthand VSCode Extension** (`FHIR-Shorthand.vscode-fsh`) - Provides syntax highlighting and language support for FSH files
- **FSH SUSHI** - Automatically installed globally via npm

### Manual Setup

If you prefer to work locally, follow these steps:

1. Clone this repository
2. Install Node.js (version 18 or higher recommended)
3. Install FSH SUSHI globally:
   ```bash
   npm install -g fsh-sushi
   ```
4. Install the [FHIR Shorthand VSCode extension](https://marketplace.visualstudio.com/items?itemName=FHIR-Shorthand.vscode-fsh) from the Visual Studio Code Marketplace

## About FHIR Shorthand

FHIR Shorthand (FSH) is a domain-specific language for defining FHIR artifacts involved in creation of FHIR Implementation Guides (IG). The goal of FSH is to allow Implementation Guide developers to author FHIR profiles, extensions, and implementation guides more efficiently and intuitively.
