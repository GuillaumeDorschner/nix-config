{ pkgs, ... }:
{
  programs.opencode = {
    enable = true;

    settings = {
      plugin = [ "opencode-models-discovery@latest" ];
      provider.ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama (local)";
        options.baseURL = "http://localhost:11434/v1";
      };
    };
  };
}
