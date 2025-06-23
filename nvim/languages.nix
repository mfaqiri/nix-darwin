{...}: {
  programs.nvf.settings.vim = {
    lsp.enable = true;
    luaConfigRC.myconfig =
      /*
      lua
      */
      ''

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        lspconfig = require('lspconfig')

        lspconfig.gdscript.setup(capabilities)

        lspconfig.cmake.setup(capabilities)

        vim.keymap.set(
              "n",
              "<leader>k",
              '<cmd>lua require("kubectl").toggle({ tab: boolean })<cr>',
              { noremap = true, silent = true }
            )


        require('nvim-treesitter').setup {

            auto_install = true,
            highlight = { enable = true },
            indent = { enable = false },
        }

      '';

    languages = {
      enableFormat = true;
      enableTreesitter = true;

      assembly.enable = true;

      bash.enable = true;

      clang.enable = true;

      csharp.enable = true;

      css.enable = true;

      go.enable = true;

      html.enable = true;

      java.enable = true;

      lua.enable = true;

      markdown = {
        enable = true;

        extensions.render-markdown-nvim.enable = true;
      };

      nix.enable = true;
      nix.format.enable = true;

      php.enable = true;

      python.enable = true;

      rust.enable = true;

      sql.enable = true;

      tailwind.enable = true;

      ts.enable = true;
    };
  };
}
