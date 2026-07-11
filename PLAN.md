Dotfiles Architecture Plan

Objetivo

Construir um repositório de dotfiles simples, sustentável e de longo prazo.

Os objetivos principais são:

* Funcionar no macOS e em ambientes Linux (incluindo Dev Containers via --dotfiles).
* Ser totalmente versionado.
* Possuir bootstrap idempotente.
* Separar claramente configuração de automação.
* Não depender de frameworks de gerenciamento de dotfiles (Dotbot, Chezmoi, GNU Stow, etc.) nesta primeira versão.
* Ser fácil de evoluir ao longo dos anos.

⸻

Princípios da arquitetura

1. Configuração é dado

O repositório deve conter apenas arquivos de configuração.

Exemplos:

* .zshrc
* .gitconfig
* ~/.config/nvim

Esses arquivos nunca devem conter lógica de instalação.

⸻

2. Automação é código

Toda a lógica de instalação deve ficar concentrada nos scripts.

Nenhum arquivo de configuração deve instalar pacotes ou alterar o sistema.

⸻

3. Bootstrap idempotente

Executar:

./install

múltiplas vezes nunca deve quebrar o ambiente.

O script deve sempre verificar o estado atual antes de executar qualquer ação.

⸻

4. Arquitetura modular

Cada responsabilidade deve viver em seu próprio módulo.

Exemplo:

* detecção do sistema operacional
* instalação de pacotes
* criação de symlinks
* instalação do Oh My Zsh

Cada módulo deve possuir apenas funções relacionadas ao seu domínio.

⸻

5. Configurações sempre versionadas

Nunca editar diretamente arquivos dentro de $HOME.

Todo arquivo deve existir dentro do repositório e ser exposto ao sistema através de symlinks.

⸻

6. Nenhum estado dentro do repositório

O repositório nunca deve armazenar:

* cache
* arquivos temporários
* secrets
* arquivos gerados

⸻

7. Portabilidade

O projeto deve funcionar igualmente em:

* macOS
* Linux
* Dev Containers

Nenhum caminho absoluto deve ser utilizado.

Todos os caminhos devem ser calculados dinamicamente.

⸻

Estrutura do projeto

dotfiles/
│
├── install
│
├── lib/
│   ├── common.sh
│   ├── os.sh
│   ├── packages.sh
│   ├── symlinks.sh
│   └── ohmyzsh.sh
│
├── home/
│   ├── .zshrc
│   └── .gitconfig
│
├── config/
│   └── nvim/
│
├── scripts/
│
├── secrets.example.zsh
│
├── README.md
│
└── .gitignore

⸻

Entry Point

O projeto possuirá apenas um ponto de entrada:

./install

Não utilizar extensão .sh no executável principal.

Internamente ele continuará sendo um script Bash.

⸻

Responsabilidades do entrypoint

O arquivo install deve:

* configurar o ambiente do bootstrap;
* descobrir a raiz do repositório;
* carregar todos os módulos de lib/;
* interpretar a task solicitada;
* executar as funções correspondentes.

Ele não deve conter lógica de negócio.

⸻

Organização dos módulos

Cada arquivo dentro de lib/ funciona como uma biblioteca.

Ele nunca deve executar código automaticamente quando carregado.

Exemplo correto:

install_packages() {
    ...
}

Exemplo incorreto:

echo "Installing..."
install_packages

Todos os módulos apenas exportam funções.

⸻

Dependências entre módulos

Somente o entrypoint pode carregar módulos.

Exemplo:

install
 ├── common.sh
 ├── os.sh
 ├── packages.sh
 ├── symlinks.sh
 └── ohmyzsh.sh

Os módulos nunca devem fazer source entre si.

Isso evita dependências circulares e facilita os testes.

⸻

Linguagem

Toda automação será escrita em Bash.

Motivos:

* Bash está presente praticamente em qualquer ambiente.
* O shell utilizado pelo usuário não interfere na execução do bootstrap.
* Facilita integração com CI, Docker, Dev Containers e sistemas Unix.

O Zsh será utilizado apenas como shell interativo do usuário.

⸻

Bash Guidelines

Todos os scripts devem iniciar com:

#!/usr/bin/env bash
set -Eeuo pipefail

Todos os scripts devem ser compatíveis com ShellCheck.

⸻

Convenções

Funções públicas

install_packages
install_ohmyzsh
create_symlinks
detect_os

⸻

Funções privadas

Prefixar com _.

Exemplo:

_install_homebrew
_install_apt
_symlink_directory

⸻

Variáveis globais

Apenas o entrypoint define caminhos globais.

Exemplo:

DOTFILES_ROOT
DOTFILES_HOME
DOTFILES_CONFIG
DOTFILES_LIB

Os módulos nunca devem calcular novamente a raiz do projeto.

⸻

Symlinks

Todo arquivo em:

home/

deve ser linkado para:

$HOME/

Todo conteúdo de:

config/

deve ser linkado para:

$HOME/.config/

A implementação deve ser genérica, sem listas fixas de arquivos.

Adicionar um novo arquivo ao repositório deve ser suficiente para que ele seja considerado durante a sincronização.

⸻

Secrets

Secrets nunca serão versionados.

Será utilizado:

~/.config/dotfiles/secrets.zsh

O .zshrc deverá carregar esse arquivo apenas quando existir.

O repositório conterá apenas:

secrets.example.zsh

para documentar as variáveis esperadas.

⸻

Oh My Zsh

A configuração do usuário deve permanecer versionada.

O bootstrap apenas garante a instalação do framework quando necessário.

Não sobrescrever configurações existentes sem confirmação.

⸻

NvChad

Seguindo a documentação oficial (https://nvchad.com/docs/quickstart/install), o NvChad é instalado uma única vez manualmente, o diretório .git do starter é removido, e os arquivos de configuração gerados passam a viver versionados dentro do repositório em config/nvim.

Não há script de instalação para o NvChad. A configuração é tratada como dado: o módulo de symlinks a mapeia para ~/.config/nvim. Na primeira execução do nvim, o lazy.nvim instala os plugins; atualizações são feitas com :Lazy sync.

⸻

Tasks

O entrypoint deve aceitar subcomandos.

Exemplos:

./install
./install packages
./install symlinks
./install ohmyzsh
./install doctor

Quando nenhuma task for informada, executar a instalação completa.

⸻

Roadmap de implementação

A implementação deve acontecer em pequenas etapas.

Fase 1

* estrutura do projeto
* README
* entrypoint
* carregamento dos módulos

⸻

Fase 2

Criar uma biblioteca interna com funções utilitárias.

Exemplos:

* logging
* mensagens coloridas
* helpers
* validações

⸻

Fase 3

Implementar o runner de tasks.

⸻

Fase 4

Implementar a detecção do sistema operacional.

⸻

Fase 5

Implementar a instalação de pacotes.

⸻

Fase 6

Implementar a criação automática de symlinks.

⸻

Fase 7

Implementar instalação do Oh My Zsh.

⸻

Fase 8

Posicionar a configuração do NvChad (instalada uma única vez, sem script) como dado versionado, mapeada via symlinks.

⸻

Fase 9

Implementar gerenciamento de secrets.

⸻

Fase 10

Implementar a task doctor, responsável por validar o ambiente e informar inconsistências.

⸻

Qualidade

Todo código novo deve:

* ser idempotente;
* possuir responsabilidade única;
* seguir ShellCheck;
* evitar duplicação;
* evitar caminhos absolutos;
* privilegiar clareza em vez de otimizações prematuras.

Antes de adicionar novas funcionalidades, sempre verificar se elas se encaixam na arquitetura existente ou se exigem uma nova abstração.
