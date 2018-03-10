# DO-Bootstrap

DO-Bootstrap is a platform for installing custom Operating Systems/Images on DigitalOcean droplets via using the user-data option to boot a custom environment to flash disk images. Examples of user-data scripts can be found in the `./example-userscripts` folder.

Note that this repo is currently based on [Buildroot 2018.02](https://github.com/buildroot/buildroot/tree/2018.02).

## Building

  1. Install the required packages on your build system:

  ```
  sudo apt-get install -y bc build-essential git libelf-dev libssl-dev unzip
  ```

  2. Run the build script:

  ```
  ./build.sh
  ```

Note that this will build and output your images to `./output`. You can then boot the provided kernel and initrd to enter the DO-Bootstrap environment.

## To-Do
 * Re-verify all image types work
 * Add retry support on flash failure

## Issues
 * You tell me!
