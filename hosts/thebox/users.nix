{config, ...}: {
  sops.secrets = {
    dom_hashedPassword.neededForUsers = true;
    poppy_hashedPassword.neededForUsers = true;
  };

  users.mutableUsers = false;

  users.groups = {
    dom.gid = 1000;
    poppy.gid = 1001;
  };

  users.users.dom = {
    uid = 1000;
    group = "dom";
    hashedPasswordFile = config.sops.secrets.dom_hashedPassword.path;
  };

  users.users.poppy = {
    createHome = false;
    isNormalUser = true;
    shell = null;
    uid = 1001;
    group = "poppy";
    hashedPasswordFile = config.sops.secrets.poppy_hashedPassword.path;
  };
}
