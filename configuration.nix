{
  inputs,
  pkgs,
  ...
}: let
  self = inputs.self;
in {
  imports = [
    ./tmux.nix
    ./nvim/nvim.nix
  ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    kitty
    kubectl
    kind
    minikube
    newman
    zoxide
    docker
    awscli2
    curl
    python3
  ];

  homebrew = {
    enable = true;

    brews = [
        "colima"
        "python"
        "pass"
      "hyperkit"
      "helm"
      "terraform"
        "pinentry-mac"
    ];

    casks = [
    "chromium"
      "postman"
      "spotify"
      "obs"
        "librewolf"
    ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
  system.primaryUser = "mfaqiri";

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
  nixpkgs.config.allowUnfree = true;
}
