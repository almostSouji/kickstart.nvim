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
    end, { desc = "[A]dd to Harpoon" })

    vim.keymap.set("n", "<leader>pa", function()
      harpoon:list():add()
    end, { desc = "Har[P]oon [A]dd" })

    vim.keymap.set("n", "<leader>pl", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Har[P]oon [L]ist" })

    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "List Harpoons" })

    vim.keymap.set("n", "<leader>p1", function()
      harpoon:list():select(1)
    end, { desc = "Har[P]oon [1]" })

    vim.keymap.set("n", "<leader>p2", function()
      harpoon:list():select(2)
    end, { desc = "Har[P]oon [2]" })

    vim.keymap.set("n", "<leader>p3", function()
      harpoon:list():select(3)
    end, { desc = "Har[P]oon [3]" })

    vim.keymap.set("n", "<leader>p4", function()
      harpoon:list():select(4)
    end, { desc = "Har[P]oon [4]" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-M-P>", function()
      harpoon:list():prev()
    end, { desc = "Previous Harpoon" })

    vim.keymap.set("n", "<C-M-N>", function()
      harpoon:list():next()
    end, { desc = "Next Harpoon" })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
