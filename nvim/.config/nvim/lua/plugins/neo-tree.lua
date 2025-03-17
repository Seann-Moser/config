return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true, -- Ensure hidden files are visible
                show_hidden_count = true,
                hide_dotfiles = false, -- Do not hide dotfiles
                hide_gitignored = false, -- Ensure gitignored files are visible
                hide_by_name = {}, -- No files explicitly hidden
                never_show = {}, -- Ensure nothing is hidden by default
            },
        }
    },
    config = function()
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')
        require("neo-tree").setup({
          filesystem = {
            filtered_items = {
              visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
              hide_dotfiles = false,
              hide_gitignored = true,
            },
          },
          window = {
            mappings = {
              ["P"] = {
                "toggle_preview",
                config = {
                  use_float = false,
                  -- use_image_nvim = true,
                  -- title = 'Neo-tree Preview',
                },
              },
            }
          }
        })
    end
}
