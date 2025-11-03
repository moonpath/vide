# Vide - Vim IDE

Vide (Vim IDE) is a ready-to-use Dockerized Neovim development environment based on [LazyVim](https://www.lazyvim.org/), providing a modern IDE experience.

## ✨ Features

- 🚀 **Ready to Use**: Pre-configured Neovim environment with no complex setup
- 🔧 **Complete Toolchain**: Integrated LSP, code formatting, debugging, and more
- 🐳 **Docker Isolation**: Containerized environment without polluting the host
- 📦 **LazyVim**: Built on modern LazyVim configuration
- 🎯 **Developer Friendly**: Pre-installed Python, Node.js, and other common development tools
- 🔍 **Enhanced Search**: Integrated fzf and ripgrep
- 📊 **Git Tools**: Built-in lazygit for visual Git operations

## 📋 Pre-installed Tools

### Editor & Configuration
- Neovim (latest stable version built from source)
- LazyVim configuration framework

### Development Tools
- **LSP Servers**: lua_ls, pyright
- **Code Formatters**: black, isort, ruff
- **Debugger**: debugpy
- **Build Tools**: cmake, ninja-build
- **Version Control**: git, lazygit

### System Tools
- Node.js & npm
- Python 3 (with pip and venv)
- fzf (fuzzy finder)
- ripgrep (fast search)
- bindfs (filesystem binding)

## 🚀 Quick Start

### Prerequisites

- Docker
- Docker Compose

### Usage

1. **Clone or create project directory**
   ```bash
   mkdir -p my-project && cd my-project
   ```

2. **Create docker-compose.yaml file** (or use the configuration from this repository)

3. **Start the container**
   ```bash
   docker-compose run --rm vide
   ```

4. **Start coding**
   ```bash
   nvim
   ```

### Working Directory

- Container working directory: `/root/workspace`
- Mount point: `./.workspace` (host) → `/workspace` (container)
- Automatic file permission mapping using bindfs

## 🔧 Configuration

### Environment Variables

Configure the following environment variables in `docker-compose.yaml`:

- `LANG`: Language setting (default: C.UTF-8)
- `TZ`: Timezone setting (default: Etc/UTC)

### Custom Neovim Configuration

Neovim configuration is located at `~/.config/nvim` inside the container. You can customize it by:

1. Enter the container
2. Edit configuration files in `~/.config/nvim/lua/config/`
3. Or add plugins to `~/.config/nvim/lua/plugins/`

For more configuration information, refer to the [LazyVim documentation](https://www.lazyvim.org/).

## 📦 Mason Tools

The project comes pre-installed with the following Mason tools:

- `lua_ls`: Lua language server
- `pyright`: Python type checker and language server
- `black`: Python code formatter
- `isort`: Python import sorter
- `ruff`: Fast Python linter
- `debugpy`: Python debugger

Run `:Mason` inside the container to manage more tools.

## 🐳 Docker Configuration

### Resource Limits

- Memory limit: 4GB
- Requires FUSE device support
- Requires SYS_ADMIN capability (for bindfs)

### Network Configuration

- Network name: vide
- Subnet: 172.20.10.0/24
- SSH port mapping: host 2222 → container 22

### Build Custom Image

To modify the base image or add tools:

1. Edit `Dockerfile`
2. Build the image:
   ```bash
   docker-compose build
   ```

Supported base images:
- `ubuntu:24.04` (default)
- `nvidia/cuda:12.9.1-cudnn-devel-ubuntu24.04` (GPU support, uncomment to use)

## 🎯 Use Cases

- Python development
- Lua development
- Node.js development
- General text editing
- Learning Vim/Neovim
- Scenarios requiring isolated development environments

## 🛠️ Common Commands

### LazyVim Keybindings

LazyVim provides rich keybindings. Here are some common ones:

- `<leader>` (default is space key)
- `<leader>ff` - Find files
- `<leader>sg` - Global search
- `<leader>gg` - Open lazygit
- `<leader>e` - Toggle file tree

Press `<leader>` in Neovim to view more keybindings.

### Lazygit

Run inside the container:
```bash
lazygit
```

Or use `<leader>gg` in Neovim.

## 📝 Notes

1. **File Permissions**: bindfs automatically handles permission mapping between host and container
2. **Data Persistence**: Working files are saved in the `.workspace` directory
3. **First Startup**: Initial image build may take a while
4. **Plugin Sync**: LazyVim automatically syncs plugins on first startup

## 🤝 Contributing

Issues and Pull Requests are welcome!

## 📄 License

The tools and software used in this project follow their respective open-source licenses.

## 🔗 Related Links

- [Neovim](https://neovim.io/)
- [LazyVim](https://www.lazyvim.org/)
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)

## 💡 Tips

If you're new to Vim, it's recommended to run `vimtutor` first to learn the basics, then check the LazyVim documentation for advanced features.

---

**Enjoy coding with Vide! 🎉**
