{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Global #
        vscodevim.vim
        natqe.reload
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode-remote.remote-containers
        gruntfuggly.todo-tree
        pkief.material-icon-theme
        mhutchie.git-graph
        usernamehw.errorlens
        hediet.vscode-drawio
        esbenp.prettier-vscode
        # continue.continue
        # DevOps #
        ms-azuretools.vscode-docker
        ms-kubernetes-tools.vscode-kubernetes-tools
        redhat.ansible
        hashicorp.terraform
        redhat.vscode-yaml
        redhat.vscode-xml
        # Language #
        # Python #
        ms-python.python
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        # Web #
        astro-build.astro-vscode
        bradlc.vscode-tailwindcss
        unifiedjs.vscode-mdx
        # Rust #
        rust-lang.rust-analyzer
        # Others #
        james-yu.latex-workshop
        mechatroner.rainbow-csv
        yzhang.markdown-all-in-one
        bierner.markdown-mermaid
        samuelcolvin.jinjahtml
      ];

      languageSnippets = {
        yaml = {
          ansibleDebugMessage = {
            prefix = "debugam";
            body = [
              "- name: Debug message"
              "  ansible.builtin.debug:"
              "    msg: >"
              "      {{ $0 }}"
            ];
            description = "Ansible debug message";
          };
          ansibleDebugVar = {
            prefix = "debugav";
            body = [
              "- name: Debug message"
              "  ansible.builtin.debug:"
              "    var: $0"
            ];
            description = "Ansible debug variable";
          };
        };
      };
      userSettings = {
        # --- Language ---
        # all
        "editor.formatOnSave" = true;
        "editor.lineNumbers" = "relative";
        "update.mode" = "none";
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "files.trimTrailingWhitespace" = true;
        "files.trimFinalNewlines" = true;
        # --- Nix ---
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };

        # --- General VSC ---
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "terminal.integrated.profiles.linux" = {
          "zsh" = {
            "path" = "${pkgs.zsh}/bin/zsh";
          };
        };
        "extensions.autoCheckUpdates" = true;
        "extensions.autoUpdate" = true;
        "chat.enabled" = false;
        "chat.agent.enabled" = false;
        "chat.commandCenter.enabled" = false;
        "github.copilot.chat.enabled" = false;
        "github.copilot.enable" = false;
        "editor.snippetSuggestions" = "top";
        "editor.inlineSuggest.enabled" = true;
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.minimap.enabled" = false;
        "editor.linkedEditing" = true;
        "git.closeDiffOnOperation" = true;
        "git.enableSmartCommit" = true;
        "workbench.sideBar.location" = "right";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.editorAssociations" = {
          "*.pdf" = "latex-workshop-pdf-hook";
        };
        "ansible.lightspeed.enabled" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmPasteNative" = false;
        "explorer.confirmDelete" = false;
        "security.workspace.trust.enabled" = false;
        "security.workspace.trust.untrustedFiles" = "newWindow";
        "redhat.telemetry.enabled" = false;
        "liveServer.settings.donotShowInfoMsg" = true;
        "application.shellEnvironmentResolutionTimeout" = 50;
        "git.autofetch" = true;
        "python.createEnvironment.trigger" = "off";
        "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python3";
        "git.confirmSync" = false;
        "window.confirmSaveUntitledWorkspace" = false;
        "terminal.integrated.enableMultiLinePasteWarning" = "never";
        "terminal.integrated.showExitAlert" = false; # termianl = exit ctrl + d --> error 127 so disable showExitAlert
        "workbench.startupEditor" = "none";
        "[dockercompose]" = {
          "editor.insertSpaces" = true;
          "editor.tabSize" = 2;
          "editor.autoIndent" = "advanced";
          "editor.defaultFormatter" = "redhat.vscode-yaml";
        };
        "[github-actions-workflow]" = {
          "editor.defaultFormatter" = "redhat.vscode-yaml";
        };
        "update.showReleaseNotes" = false;

        # --- Extensions ---
        # Prettier
        "prettier.singleQuote" = false;
        "prettier.trailingComma" = "all";
        "prettier.printWidth" = 120;

        # Todo-Tree
        "todo-tree.filtering.excludeGlobs" = [ "**/node_modules/*" ];
        "todo-tree.general.tags" = [
          "BUG"
          "HACK"
          "FIXME"
          "TODO"
          "[ ]"
          "[x]"
        ];
      };
      keybindings = [
        {
          key = "ctrl+alt+b";
          command = "editor.emmet.action.balanceOut";
        }
        {
          key = "ctrl+alt+v";
          command = "editor.emmet.action.balanceIn";
        }
        {
          key = "ctrl+n";
          command = "explorer.newFile";
          when = "explorerViewletFocus";
        }
        {
          key = "ctrl+shift+n";
          command = "explorer.newFolder";
          when = "explorerViewletFocus";
        }
        {
          key = "ctrl+alt+m";
          command = "workbench.action.togglePanel";
        }
        {
          key = "ctrl+alt+f";
          command = "workbench.action.toggleMaximizedPanel";
        }
        {
          key = "ctrl+[BracketRight]";
          command = "workbench.action.terminal.focus";
        }
        {
          key = "ctrl+[BracketRight]";
          command = "workbench.action.focusActiveEditorGroup";
          when = "terminalFocus";
        }
        {
          key = "ctrl+shift+[BracketRight]";
          command = "workbench.action.terminal.new";
          when = "terminalProcessSupported || terminalWebExtensionContributedProfile";
        }
        {
          key = "ctrl+down";
          command = "-workbench.action.terminal.focus";
          when = "accessibilityModeEnabled && accessibleViewOnLastLine && terminalHasBeenCreated && accessibleViewCurrentProviderId == 'terminal' || accessibilityModeEnabled && accessibleViewOnLastLine && terminalProcessSupported && accessibleViewCurrentProviderId == 'terminal'";
        }
        {
          key = "ctrl+alt+meta+up";
          command = "workbench.action.terminal.resizePaneUp";
        }
        {
          key = "ctrl+alt+meta+down";
          command = "workbench.action.terminal.resizePaneDown";
        }
        {
          key = "ctrl+alt+down";
          command = "workbench.action.terminal.focusNext";
          when = "terminalFocus && terminalHasBeenCreated && !terminalEditorFocus || terminalFocus && terminalProcessSupported && !terminalEditorFocus";
        }
        {
          key = "ctrl+alt+up";
          command = "workbench.action.terminal.focusPrevious";
          when = "terminalFocus && terminalHasBeenCreated && !terminalEditorFocus || terminalFocus && terminalProcessSupported && !terminalEditorFocus";
        }
        {
          key = "alt+d";
          command = "editor.action.peekDefinition";
          when = "editorHasDefinitionProvider && editorTextFocus && !inReferenceSearchEditor && !isInEmbeddedEditor";
        }
        {
          key = "f12";
          command = "-editor.action.revealDefinition";
          when = "editorHasDefinitionProvider && editorTextFocus";
        }
        {
          key = "shift+alt+k shift+alt+d";
          command = "editor.action.revealDefinitionAside";
          when = "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor";
        }
        {
          key = "alt+v";
          command = "toggleVim";
        }
        {
          key = "";
          command = "markdown.showPreview";
          when = "!notebookEditorFocused && editorLangId =~ /^(markdown|prompt|instructions|chatmode)$/";
        }
        {
          key = "ctrl+p";
          command = "-extension.vim_ctrl+p";
          when = "editorTextFocus && vim.active && vim.use<C-p> && !inDebugRepl || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'SearchInProgressMode'";
        }
        {
          key = "ctrl+n";
          command = "-workbench.action.chat.newChat";
          when = "chatIsEnabled && inChat";
        }
        {
          key = "ctrl+n";
          command = "-workbench.action.openChat";
          when = "chatIsEnabled && inChat && inChatEditor";
        }
        {
          key = "ctrl+n";
          command = "-chatEditor.action.undoHunk";
          when = "chatEdits.hasEditorModifications && editorFocus && !chatEdits.isRequestInProgress || chatEdits.hasEditorModifications && notebookCellListFocused && !chatEdits.isRequestInProgress";
        }
        {
          key = "ctrl+n";
          command = "-extension.vim_ctrl+n";
          when = "editorTextFocus && vim.active && vim.use<C-n> && !inDebugRepl || vim.active && vim.use<C-n> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-n> && !inDebugRepl && vim.mode == 'SearchInProgressMode'";
        }
        {
          key = "ctrl+w";
          command = "-extension.vim_ctrl+w";
          when = "editorTextFocus && vim.active && vim.use<C-w> && !inDebugRepl";
        }
        {
          key = "ctrl+shift+[Backquote]";
          command = "-workbench.action.terminal.new";
          when = "terminalProcessSupported || terminalWebExtensionContributedProfile";
        }
        {
          key = "ctrl+[BracketRight]";
          command = "workbench.action.terminal.focus";
          when = "accessibilityModeEnabled && accessibleViewOnLastLine && terminalHasBeenCreated && accessibleViewCurrentProviderId == 'terminal' || accessibilityModeEnabled && accessibleViewOnLastLine && terminalProcessSupported && accessibleViewCurrentProviderId == 'terminal'";
        }
      ];
    };
  };
}
