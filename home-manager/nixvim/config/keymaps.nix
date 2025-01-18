[
  # open neagit
  {
    key = "<leader>G";
    action = "<cmd>Neogit<CR>";
  }
  # open oil
  {
    key = "<leader>pv";
    action = "<cmd>Oil --float<CR>";
  }

  # format
  {
    key = "<leader>fm";
    action = "<cmd>:AsyncRun nix fmt<CR>";
  }
  {
    key = "<leader>fmo";
    action = "<cmd>:copen<CR>";
  }

  # exit terminal mode
  {
    mode = "t";
    key = "<esc>";
    action = "<C-\\><C-n>";
  }

  # previous buffer
  {
    key = "<leader>bp";
    action = "<cmd>bp<CR>";
  }
  # next buffer
  {
    key = "<leader>bn";
    action = "<cmd>bn<CR>";
  }

  # pane switching
  {
    key = "<leader>h";
    action = "<C-w><C-h>";
  }
  {
    key = "<leader>j";
    action = "<C-w><C-j>";
  }
  {
    key = "<leader>k";
    action = "<C-w><C-k>";
  }
  {
    key = "<leader>l";
    action = "<C-w><C-l>";
  }

  # pane existence
  {
    key = "<leader>s";
    action = "<cmd>split<CR>";
  }
  {
    key = "<leader>v";
    action = "<cmd>vsplit<CR>";
  }
  {
    key = "<leader>q";
    action = "<cmd>q<CR>";
  }
]
