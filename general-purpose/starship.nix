{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    
    settings = {
      add_newline = false;
      continuation_prompt = "❯❯";
      scan_timeout = 10;
      
      battery.format = "[\[](bold black)[$symbol$percentage]($style)[\]──](bold black)";
      git_branch.format = "──[\[](black)[$symbol$branch](cyan)[\]](black)";
      git_state.format = "──[\[](black)[$state( $progress_current/$progress_total)](cyan)[\]](black)";

      directory = {
        read_only = "";
        truncation_length = 10;
        truncate_to_repo = false;
      };

      character = {
        success_symbol = "[❯❯](cyan) ";
        error_symbol = "[✗](bold red) ";
      };

      username = {
        style_user = "cyan";
        format = "[$user]($style)";
        show_always = true;
      };

      hostname = {
        style = "cyan";
        format = "[$hostname]($style)";
        ssh_only = false;
      };

      format = ''
        [┌─](bold black)[\[](black)[  ](cyan)[\]──\[ ](black)[$directory](bold cyan)[\]](black)$branch$state
        [└─](bold black)[\[](black)[$username](cyan)[@](bold black)[$hostname](cyan)[\]](black)[$state](cyan)[──$character](black)
      '';

      right_format = ''
        $battery[⚡](bold black)
      '';
    };
  };
}
