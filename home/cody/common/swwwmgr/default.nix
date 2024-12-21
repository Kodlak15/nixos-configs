{}
# {pkgs, ...}: {
#   home.packages = [pkgs.swww-manager];
#   xdg.configFile."swwwmgr/config.yaml".text = ''
#     pywal: true
#     transition:
#       angle: "45"
#       duration: "3"
#       position: "center"
#       step: "90"
#       type: fade
#   '';
# }
# NOTE: disabing this temporarily
# TODO figure out how to get flake working
# {
#   pkgs,
#   inputs,
#   ...
# }: {
#   home.packages = [inputs.swwwmgr.${pkgs.system}.default];
#   xdg.configFile."swwwmgr/config.yaml".text = ''
#     transition:
#       angle: "45"
#       duration: "3"
#       position: "center"
#       step: "90"
#       type: fade
#   '';
# }

