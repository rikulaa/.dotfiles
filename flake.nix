{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

    nixpkgs-neovim.url = "github:NixOS/nixpkgs/c9baf8b27b3e1114b13b6406d58e1f6c500eae30";
  };

  outputs = inputs: {
    packages = builtins.mapAttrs (system: pkgs: {
      # For indivially available package
      # hello = pkgs.hello;
      # stow = pkgs.stow;

      default = pkgs.buildEnv {
      	name = "Base packages";
	paths = [
          pkgs.stow 
          pkgs.direnv 
          pkgs.jq 
          pkgs.ripgrep 
          pkgs.shellcheck 
          pkgs.asciidoctor 
          pkgs.tmux 
          pkgs.wget 
          pkgs.htop 
          pkgs.tldr 
          pkgs.git 
          pkgs.ffmpeg
          # In unstable
          pkgs.fzf
          pkgs.harper
          pkgs.lua51Packages.tree-sitter-cli
          # 0.12.*
          inputs.nixpkgs-neovim.legacyPackages.${system}.neovim
	];
      };
    }) inputs.nixpkgs.legacyPackages;
  };
}
