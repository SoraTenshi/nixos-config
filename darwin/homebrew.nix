{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      "homebrew/cask"
    ];
    brews = [
      
    ];
    casks = [
      "ubersicht"
      "alfred"
    ];
  };
}