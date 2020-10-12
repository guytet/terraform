# Terraform libvirt provider
Sourec: 
https://github.com/dmacvicar/terraform-provider-libvirt

For quick and cheap (as in not paying for cloud computing), nice to have some standard IAC options for libvirt. 

This module will provision vm's using a bionic cloud image, will expand the image to ~16GB (default disk is 2GB), connect to the system's bridge (assuming one is configured), push ssh keys, run commands, etc. 