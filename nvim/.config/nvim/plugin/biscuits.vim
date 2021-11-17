lua <<EOF
require('nvim-biscuits').setup({
  default_config = {
    min_distance = 3,
    prefix_string = "  "
  },
  show_on_start = true,
  toggle_keybind = "<leader>cb"
})

EOF

