{ pkgs, ... }:
{
  programs.opencode = {
    enable = true;

    settings = {
      model = "ollama/qwen3-coder:latest";
      provider.ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama (local)";
        options.baseURL = "http://localhost:11434/v1";
        models = {
          "qwen3-coder:latest" = {
            name = "Qwen3 Coder";
          };
          "qwen3.6:27b" = {
            name = "Qwen3.6 27B";
          };
          "qwen3.6:35b" = {
            name = "Qwen3.6 35B";
          };
          "llama3.3:latest" = {
            name = "Llama 3.3";
          };
        };
      };
    };
  };
}
