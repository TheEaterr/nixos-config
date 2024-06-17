{config, ...}: {
  programs.micro.enable = true;
  programs.micro.catppuccin.enable = true;

  programs.micro.settings = {
    clipboard = "terminal";
  };

  home.file.".config/micro/bindings.json".text = ''
    {
      "\u001b[107;6u": "DeleteLine",
      "\u001b[112;6u": "CommandMode",
      "\u001b[115;6u": "SaveAs",
      "\u003cCtrl-k\u003e\u003cCtrl-d\u003e": "SkipMultiCursor",
      "Alt-/": "lua:comment.comment",
      "Alt-z": "lua:initlua.toggleSoftwrap",
      "Ctrl-:": "lua:comment.comment",
      "Ctrl-d": "SpawnMultiCursor",
      "Ctrl-g": "command-edit:goto ",
      "Ctrl-l": "SelectLine",
      "Ctrl-n": "AddTab",
      "Ctrl-q": "QuitAll",
      "Ctrl-u": "RemoveMultiCursor",
      "Ctrl-w": "Quit",
      "CtrlBackspace": "DeleteWordLeft",
      "CtrlDelete": "DeleteWordRight",
      "CtrlDown": "ScrollDown",
      "CtrlLeft": "WordLeft",
      "CtrlPageDown": "NextTab",
      "CtrlPageUp": "PreviousTab",
      "CtrlRight": "WordRight",
      "CtrlShiftAltDown": "DuplicateLine",
      "CtrlShiftBackspace": "JumpToMatchingBrace",
      "CtrlAltDown": "SpawnMultiCursorDown",
      "CtrlShiftEnd": "SelectToEnd",
      "CtrlShiftHome": "SelectToStart",
      "CtrlShiftLeft": "SelectWordLeft",
      "CtrlShiftRight": "SelectWordRight",
      "CtrlAltUp": "SpawnMultiCursorUp",
      "CtrlSpace": "Autocomplete",
      "CtrlUnderscore": "lua:comment.comment",
      "CtrlUp": "ScrollUp",
      "F3": "FindNext",
      "OldBackspace": "DeleteWordLeft",
      "ShiftDelete": "CutLine",
      "ShiftEscape": "RemoveAllMultiCursors",
      "ShiftF3": "FindPrevious",
      "ShiftPageDown": "SelectPageDown",
      "ShiftPageUp": "SelectPageUp",
      "Tab": "IndentSelection|InsertTab"
    }
  '';

  home.file.".config/micro/init.lua".text = ''
    -- https://github.com/zyedidia/micro/issues/1806
    function toggleSoftwrap(bp)
      bp.Buf.Settings["softwrap"] = not bp.Buf.Settings["softwrap"]
    end
  '';
}
