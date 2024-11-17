# TODO(nenikitov): Make settings to disable extensions
# TODO(nenikitov): Make settings to disable installation through browser
{
  lib,
  config,
  ...
} @ attrs: let
  makeExtension = {
    enableOptionName ? name,
    name,
    storeId ? null,
    url ? null,
    settingsPolicy,
    ...
  }: let
    install_url =
      if url != null && storeId == null
      then url
      else if storeId != null && url == null
      then "https://addons.mozilla.org/en-US/firefox/downloads/latest/${storeId}/latest.xpi"
      else throw "Exactly one of `storeId` or `url` for extension ${name} must be provided, not both or neither";
  in
    lib.mkIf config.ne.firefox.extensions.${enableOptionName} {
      ExtensionSettings = {
        "${name}" = {
          inherit install_url;
          installation_mode = "force_installed";
        };
      };
      "3rdparty".Extensions = {
        "${name}" = settingsPolicy;
      };
    };
  extensions = lib.map (e: import e attrs) [
    ./ublock-origin.nix
    ./dark-reader.nix
  ];
in {
  options = {
    ne.firefox.extensions = lib.listToAttrs (lib.map ({
        name,
        enableOptionName ? name,
        ...
      }: {
        name = enableOptionName;
        value = lib.mkEnableOption "${enableOptionName} extension";
      })
      extensions);
  };

  config = {
    programs.firefox.policies = lib.mkMerge (lib.map (e: makeExtension e) extensions);
  };
}
