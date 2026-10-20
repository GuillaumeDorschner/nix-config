{ inputs, pkgs, ... }:
{
  imports = [ inputs.pi-nix.homeManagerModules.default ];

  programs.pi = {
    enable = true;
    package = inputs.pi-nix.packages.${pkgs.system}.default;

    packages = [
      "npm:pi-subagents"
      "npm:pi-web-access"
      "npm:pi-mcp-adapter"
    ];

    provider = "anthropic";
    model = "claude-sonnet-5-5";
    defaultThinkingLevel = "medium";

    customProviders = {
      ollama-local = {
        name = "Ollama (local)";
        baseUrl = "http://localhost:11434/v1";
        apiKey = "ollama"; # dummy
        models = [
          {
            id = "REPLACE-with-ollama-list";
            name = "Local";
          }
        ];
      };

      ollama-server = {
        name = "Ollama (server)";
        baseUrl = "http://YOUR-SERVER:11434/v1";
        apiKey = "$ANTHROPIC_API_KEY";
        models = [
          {
            id = "REPLACE-with-ollama-list";
            name = "Server";
          }
        ];
      };
    };

    preLaunchHook = ''
      export ANTHROPIC_API_KEY="$(cat /run/secrets/ai/anthropic_api_key)"
      export OPENAI_API_KEY="$(cat /run/secrets/ai/openai_api_key)"
    '';

    mutableSettings = true;
  };
}
