{ pkgs, user, ... }:

{
  programs = {
    chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        { id = "bgnkhhnnamicmpeenaelnjfhikgbkllg"; } # Adguard Blocker
        { id = "fdjamakpfbbddfjaooikfcpapjohcfmg"; } # Dashlane
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
        { id = "gebbhagfogifgggkldgodflihgfeippi"; } # Return YouTube Dislike
        { id = "gabfmnliflodkdafenbcpjdlppllnemd"; } # Save image as Type
        { id = "pfnededegaaopdmhkdmcofjmoldfiped"; } # Proxy SwitchOmega 3
      ];
      commandLineArgs = [
        "--disable-features=WebRtcAllowInputVolumeAdjustment"
        "--allow-insecure-localhost"
        "--restore-last-session"
        "--disable-search-engine-choice-screen"
      ];
    };
  };
}
