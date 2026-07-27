{ config, pkgs, inputs, ... }:
{
  services.udev.extraRules = ''
    # Vault 35 WKL Pipboy
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="a457", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="a457", MODE="0660", GROUP="input"
    # WLmouse Huan
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a863", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a863", MODE="0660", GROUP="input"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a864", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a864", MODE="0660", GROUP="input"
    # WLmouse Beast G Mini
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a860", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a860", MODE="0660", GROUP="input"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a861", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a861", MODE="0660", GROUP="input"
  '';
  services.udev.enable = true;
}
