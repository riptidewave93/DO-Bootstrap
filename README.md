DO-Bootstrap
====

DO-Bootstrap is a platform for installing custom Operating Systems/Images on DigitalOcean droplets via using the user-data option to boot a custom environment to flash custom disk images.

Examples of this can be found in the `./example-userscripts` folder.

Building
----
 1. Place your stock initrd.img of choice in the root directory (this repo currently uses a Debian 8.3 x64 initrd/kernel)
 2. Run `./build.sh initrd.img` where initrd.img is the name of the initrd.img file
 3. Once done, use one of the `./example-userscripts` to point to your kernel and custom initrd, which will be stored in `./output`


Adding Features
----
This process works by taking the stock `initrd.img` file and applying the contents of `./overlay` to the image. To add features to the flasing process, you will want to add these to `./overlay/scripts/init-bottom/do-bootstrap`
