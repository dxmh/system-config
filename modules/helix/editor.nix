{
  cursorline = true;
  auto-save = true;
  line-number = "relative";
  color-modes = true;
  file-picker.hidden = false;
  indent-guides = {
    render = true;
    character = "╎";
  };
  smart-tab.enable = true;
  soft-wrap.enable = false;
  whitespace.render = {
    space = "none";
    tab = "none";
    newline = "all";
  };
  whitespace.characters = {
    newline = "↩";
  };
  statusline = {
    right = [
      "diagnostics"
      "selections"
      "position"
      "file-encoding"
      "spacer"
      "version-control"
      "spacer"
    ];
  };
}
