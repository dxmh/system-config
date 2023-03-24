{
  normal = {
    "#" = "toggle_comments";
    "C-C" = "yank_main_selection_to_clipboard";
    "C-c" = "yank_joined_to_clipboard";
    "C-l" = ":reload";
    "C-v" = "replace_selections_with_clipboard";

    space.c.r = ":reset-diff-change";
    space.c.p = "goto_prev_change";
    space.c.n = "goto_next_change";

    space.e = ":reflow";
    space.n = ":new";
    space.space = "goto_last_accessed_file";

    space.q = ":q";
    space.Q = ":q!";
    space.w = ":w";
    space.W = ":w!";
    space.x = ":x";

    space.o.w = ":toggle-option soft-wrap.enable";
    space.o.c = ":toggle-option cursorline";

    Z.d = "half_page_down";
    Z.u = "half_page_up";

    # Horrible bodge for toggling spellcheck:
    "[".o.s = ":lang markdown";
    "]".o.s = [":config-reload" ":lsp-restart"];
  };

  select = {
    "#" = "toggle_comments";
    "C-C" = "yank_main_selection_to_clipboard";
    "C-c" = "yank_joined_to_clipboard";
  };
}
