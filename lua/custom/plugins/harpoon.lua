-- Getting where you want with fewer keystrokes
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "[A]dd Harpoon" })

    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "List Harpoons" })

    vim.keymap.set("n", "<leader>f", function()
      harpoon:list():select(1)
    end, { desc = "[F]irst Harpoon" })

    vim.keymap.set("n", "<leader>s", function()
      harpoon:list():select(2)
    end, { desc = "[S]econd Harpoon" })

    vim.keymap.set("n", "<leader>t", function()
      harpoon:list():select(3)
    end, { desc = "[T]hird Harpoon" })

    vim.keymap.set("n", "<leader>ff", function()
      harpoon:list():select(4)
    end, { desc = "[FF]ourth Harpoon" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function()
      harpoon:list():prev()
    end, { desc = "Previous Harpoon" })

    vim.keymap.set("n", "<C-S-N>", function()
      harpoon:list():next()
    end, { desc = "Next Harpoon" })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
