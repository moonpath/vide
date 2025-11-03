ARG BASE_IMAGE="ubuntu:24.04"
# ARG BASE_IMAGE="nvidia/cuda:12.9.1-cudnn-devel-ubuntu24.04"
FROM $BASE_IMAGE AS base_image

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    git \
    build-essential \
    cmake \
    ninja-build \
    unzip \
    luarocks \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    bindfs

RUN git clone https://github.com/neovim/neovim.git /tmp/neovim && \
    cd /tmp/neovim && \
    make CMAKE_BUILD_TYPE=Release && \
    make install

RUN git clone https://github.com/LazyVim/starter ~/.config/nvim && \
    mkdir -p ~/.config/nvim/lua/config && \
    grep -qF 'vim.o.shell = "bash"' ~/.config/nvim/lua/config/options.lua || \
    echo 'vim.o.shell = "bash"' >> ~/.config/nvim/lua/config/options.lua && \
    mkdir -p ~/.config/nvim/lua/plugins && \
    cat <<EOF > ~/.config/nvim/lua/plugins/mason-tool-installer.lua && \
    nvim --headless "+MasonToolsInstallSync" +qa && \
    (timeout 15s nvim --headless "+TSUpdate" || true) && \
    nvim --headless "+Lazy! sync" +qa

return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
        ensure_installed = {
            "lua_ls",
            "pyright",
            "black",
            "isort",
            "ruff",
            "debugpy",
        },
    },
}
EOF

RUN curl -L https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz | \
    tar -xz -C /usr/local/bin lazygit

RUN apt-get install -y \
    fd-find \
    fzf \
    ripgrep

RUN apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

RUN cat <<'EOF' > /usr/local/bin/docker-entrypoint && chmod +x /usr/local/bin/docker-entrypoint
#!/bin/bash
set -x

SOURCE_DIR="/workspace"
TARGET_DIR="/root/workspace"

mkdir -p $TARGET_DIR

if [ -d $SOURCE_DIR ]; then
    SOURCE_UID=$(stat -c '%u' $SOURCE_DIR)
    SOURCE_GID=$(stat -c '%g' $SOURCE_DIR)
    TARGET_UID=$(stat -c '%u' $TARGET_DIR)
    TARGET_GID=$(stat -c '%g' $TARGET_DIR)

    bindfs \
        -o allow_other \
        --map=$SOURCE_UID/$TARGET_UID:@$SOURCE_UID/@$TARGET_UID \
        --create-for-user=$SOURCE_UID \
        --create-for-group=$SOURCE_GID \
        $SOURCE_DIR $TARGET_DIR || true
fi

set -ex
exec "$@"
EOF

WORKDIR /root/workspace

CMD ["bash"]
ENTRYPOINT ["docker-entrypoint"]