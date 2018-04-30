gentoo-overlay
==============

## Adding the overlay using layman

First create a local overlay list:

```sh
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE repositories SYSTEM "/dtd/repositories.dtd">
<repositories xmlns="" version="1.0">
  <repo quality="experimental" status="unofficial">
    <name>bingch</name>
    <description>bingch local ebuilds</description>
    <homepage>https://github.com/bingch/gentoo-overlay</homepage>
    <owner type="project">
       <email>bingquick@hotmail.com</email>
       <name>Bing Chen</name>
    </owner>
    <source type="git">https://github.com/bingch/gentoo-overlay.git</source>
    <feed>https://github.com/feeds/bingch/commits/gentoo-overlay/master</feed>
  </repo>
</repositories>' > /etc/layman/overlays/bingch.xml
```

Then make it known to layman and add it to your local overlays:

```sh
layman -L
layman -a bingch
```
