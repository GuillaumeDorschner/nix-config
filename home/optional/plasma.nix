{
  xdg.dataFile = {
    "kwin/scripts/myscript/metadata.json".text = ''
      {
      "KPlugin": {
          "Name": "My Script",
          "Description": "Custom windows manager like manget in macos",
          "Icon": "preferences-system-windows",
          "Authors": [
              {
                  "Email": "username@gmail.com",
                  "Name": "Firstname Lastname"
              }
          ],
          "Id": "myscript",
          "Version": "1.0",
          "License": "GPLv3",
          "Website": "https://github.com/username/myscript"
      },
      "X-Plasma-API": "javascript",
      "X-Plasma-MainScript": "code/main.js",
      "KPackageStructure": "KWin/Script"
      }
    '';

    "kwin/scripts/myscript/contents/code/main.js".text = ''
      var previousGeometries = new Map();

      function tileWindow(x, y, w, h) {
        var win = workspace.activeWindow;
        var area = workspace.clientArea(KWin.MaximizeArea, win);

        if (win) {
          previousGeometries.set(win.internalId, {
            x: win.frameGeometry.x,
            y: win.frameGeometry.y,
            width: win.frameGeometry.width,
            height: win.frameGeometry.height
          });
          win.frameGeometry = {
            x: area.x + Math.round(area.width * x),
            y: area.y + Math.round(area.height * y),
            width: Math.round(area.width * w),
            height: Math.round(area.height * h),
          };
        }
      }

      function restoreWindow() {
        var win = workspace.activeWindow;
        if (win) {
          var prev = previousGeometries.get(win.internalId);
          if (prev) {
            win.frameGeometry = prev;
          }
        }
      }

      function shortcut(name, key, x, y, w, h) {
          registerShortcut(
              name,
              name,
              key,
              () => tileWindow(x, y, w, h)
          );
      }

      shortcut("Tile Full",  "Ctrl+Meta+Return",   0,   0, 1, 1);
      registerShortcut("Restore Window", "Restore Window", "Ctrl+Meta+Backspace", restoreWindow);
      shortcut("Tile Half Left",  "Ctrl+Meta+Left",   0,   0, 0.5, 1);
      shortcut("Tile Half Right", "Ctrl+Meta+Right",  0.5, 0, 0.5, 1);

      shortcut("Tile 1/3 Left",   "Ctrl+Meta+D",  0,   0, 1/3, 1);
      shortcut("Tile 1/3 Center", "Ctrl+Meta+F",  1/3, 0, 1/3, 1);
      shortcut("Tile 1/3 Right",  "Ctrl+Meta+G",  2/3, 0, 1/3, 1);
      shortcut("Tile 2/3 Left",   "Ctrl+Meta+E",  0,   0, 2/3, 1);
      shortcut("Tile 2/3 Right",  "Ctrl+Meta+T",  1/3, 0, 2/3, 1);

      shortcut("Tile 1/6 Slot 1", "Ctrl+Meta+1",  0,   0, 1/6, 1);
      shortcut("Tile 1/6 Slot 2", "Ctrl+Meta+2",  1/6, 0, 1/6, 1);
      shortcut("Tile 1/6 Slot 3", "Ctrl+Meta+3",  2/6, 0, 1/6, 1);
      shortcut("Tile 1/6 Slot 4", "Ctrl+Meta+4",  3/6, 0, 1/6, 1);
      shortcut("Tile 1/6 Slot 5", "Ctrl+Meta+5",  4/6, 0, 1/6, 1);
      shortcut("Tile 1/6 Slot 6", "Ctrl+Meta+6",  5/6, 0, 1/6, 1);
    '';

  };

  programs.plasma = {
    enable = true;
    # overrideConfig = true # Test this if the plasma i making be up to your mischief again
    workspace = {
      wallpaper = ../../asserts/wallpaper.jpeg;
      lookAndFeel = "org.kde.breezetwilight.desktop"; # TODO: test if this is the reson of the background not working
    };
    kscreenlocker = {
      autoLock = true;
      lockOnResume = true;
      timeout = 2;
      passwordRequired = true;
      passwordRequiredDelay = 5;
      appearance.wallpaper = ../../asserts/wallpaper.jpeg;
    };
    desktop = {
      icons = {
        arrangement = "topToBottom";
        alignment = "left";
        lockInPlace = true;
        sorting = {
          foldersFirst = true;
        };
      };
    };
    windows = {
      allowWindowsToRememberPositions = true;
    };
    configFile."kwinrc"."Plugins"."myscriptEnabled" = true;
  };
}
