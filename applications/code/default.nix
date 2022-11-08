{ pkgs, unstable, ... }:
let

  managedExtensions = map pkgs.vscode-utils.extensionFromVscodeMarketplace (builtins.fromJSON (builtins.readFile ./managed.json));

  updateScript = pkgs.writers.writePython3Bin "code-ext-update"
    {
      libraries = [ pkgs.python3Packages.requests ];
      flakeIgnore = [ "E501" ];
    }
    (builtins.readFile ./update.py);

in
{

  programs.vscode = {
    enable = true;
    package = unstable.vscode;
    userSettings = {
      "editor.fontFamily" = "'FiraCode Nerd Font'";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 12;
      "editor.fontWeight" = "normal";
      "editor.minimap" = {
        "maxColumn" = 60;
        "renderCharacters" = false;
        "size" = "fit";
      };
      "editor.renderWhitespace" = "all";
      "editor.tabSize" = 2;
      "editor.wordWrapColumn" = 100;
      "explorer.confirmDelete" = false;
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 500;
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;
      "files.watcherExclude" = {
        "**/.ammonite" = true;
        "**/.bloop" = true;
        "**/.metals" = true;
        "**/target" = true;
      };
      "metals" = {
        "bloopSbtAlreadyInstalled" = true;
        "showInferredType" = true;
        "javaHome" = pkgs.jdk.home;
      };
      "oneDarkPro.vivid" = true;
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.fontFamily" = "'FuraCode Nerd Font'";
      "terminal.integrated.fontSize" = 12;
      "update.mode" = "none";
      "window.restoreFullscreen" = true;
      "window.zoomLevel" = 0;
      "workbench.colorTheme" = "One Dark Pro";
      "workbench.iconTheme" = "material-icon-theme";
      "redhat.telemetry.enabled" = false;
      "[python]" = {
        "editor.tabSize" = 4;
      };
    };

    extensions = (with pkgs.vscode-extensions; [
      # ms-vsliveshare.vsliveshare
      ms-python.python
      matklad.rust-analyzer # rust-lang.rust-analyzer
    ]) ++ managedExtensions;
  };

  home.packages = [
    updateScript
  ];
}
