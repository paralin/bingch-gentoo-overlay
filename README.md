gentoo-overlay
==============

## Adding local repo using eselect (need app-eselect/eselect-repository installed)

sudo eselect repository add bingch git https://gitlab.com/bingch/gentoo-overlay.git

## Adding the overlay using layman

First create a local overlay list:

```sh
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE repositories SYSTEM "/dtd/repositories.dtd">
<repositories xmlns="" version="1.0">
  <repo quality="experimental" status="unofficial">
    <name>bingch</name>
    <description>bingch local ebuilds</description>
    <homepage>https://gitlab.com/bingch/gentoo-overlay</homepage>
    <owner type="project">
       <email>bingquick@hotmail.com</email>
       <name>Bing Chen</name>
    </owner>
    <source type="git">https://gitlab.com/bingch/gentoo-overlay.git</source>
    <feed>https://gitlab.com/feeds/bingch/commits/gentoo-overlay/master</feed>
  </repo>
</repositories>' > /etc/layman/overlays/bingch.xml
```

Then make it known to layman and add it to your local overlays:

```sh
layman -L
layman -a bingch
```

## Setup for pinephone https://www.pine64.org/pinephone/

* follow https://wiki.gentoo.org/wiki/Cross_build_environment to setup cross build enviroment in your gentoo host
* cross compile @system, rsync -azvP /usr/aarch64-unknown-linux-gnu/ /root/partition/SD
* cross compile kernel https://wiki.gentoo.org/wiki/Embedded_Handbook/General/Cross-compiling_the_kernel, either use upstream 5.12/5.13 kernel with mergi's patch in https://xff.cz/kernels/, or just download the compiled one, which seems to be needed if you choose to use p-boot, or the original https://gitlab.com/pine64-org/linux for u-boot 
* cross compile p-boot https://xnux.eu/p-boot/ or u-boot https://linux-sunxi.org/U-Boot install kernel/dtbs/etc to boot partition
* put SD card in pinephone and to test boot pinephone to verify basic setup works ok
* aarch64-unknown-linux-gnu-emerge pinephone phosh-meta -av --keep-going should pull in all pkgs to start phosh. Not all packages are cross compilable, you will need to build the failed one in chroot or on the phone itself
