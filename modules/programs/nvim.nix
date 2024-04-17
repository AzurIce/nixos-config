inputs@{ pkgs, user, nvim-config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true; # Set env EDITOR = nvim
    viAlias = true;
    vimAlias = true;
#    extraLuaConfig = ''
#    local rocks_config = {
#        rocks_path = vim.fn.stdpath("data") .. "/rocks",
#        luarocks_binary = "${pkgs.lua51Packages.luarocks}/bin/luarocks", 
#    }

#    vim.g.rocks_nvim = rocks_config

#    local luarocks_path = {
#        vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
#        vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
#    }
#    package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

#    local luarocks_cpath = {
#        vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
##        vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
#    }
#    package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

#    if not vim.uv.fs_stat(rocks_config.rocks_path) then
#      vim.system({
#        rocks_config.luarocks_binary,
#        "install",
#        "--tree",
#        rocks_config.rocks_path, 
#        "--server='https://nvim-neorocks.github.io/rocks-binaries/'",
#        "--lua-version=5.1",
#        "rocks.nvim",
#        }):wait()
#    end

#    vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))
#    '';
  };

  # home.file.".config/nvim/rocks.toml".source = "${nvim-config}/rocks.toml";
  home.file.".config/nvim".source = nvim-config;
}
