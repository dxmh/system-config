{
  normal."#" = "toggle_comments";
  normal."C-C" = "yank_main_selection_to_clipboard";
  normal."C-c" = "yank_joined_to_clipboard";
  normal."C-l" = ":reload";
  normal."C-v" = "replace_selections_with_clipboard";

  normal.space.c.r = ":reset-diff-change";
  normal.space.c.p = "goto_prev_change";
  normal.space.c.n = "goto_next_change";

  normal.space.e = ":reflow";
  normal.space.n = ":new";
  normal.space.space = "goto_last_accessed_file";

  normal.space.q = ":q";
  normal.space.Q = ":q!";
  normal.space.w = ":w";
  normal.space.W = ":w!";
  normal.space.x = ":x";

  normal.space.o.w = ":toggle-option soft-wrap.enable";
  normal.space.o.c = ":toggle-option cursorline";

  normal.Z.d = "half_page_down";
  normal.Z.u = "half_page_up";

  # Horrible bodge for toggling spellcheck:
  normal."[".o.s = ":lang markdown";
  normal."]".o.s = [":config-reload" ":lsp-restart"];

  normal."A-z" = "undo";
  normal."A-Z" = "redo";

  select."#" = "toggle_comments";
  select."C-C" = "yank_main_selection_to_clipboard";
  select."C-c" = "yank_joined_to_clipboard";
}
