# uc-launch

This snap contains scripts to quickly and easily launch Ubuntu Core virtual
machines using QEMU and KVM.

Usage: `uc-launch[.command] [--ssh-port <port number>] <ubuntu-core.img>`

Commands:
  - `uc-launch` - the default invocation
  - `uc-launch.check` - Checks if KVM support is available on the host machine
  - `uc-launch.no-gui` - force terminal only mode, with no virtualized display
  - `uc-launch.gui` - force the use of a virtualized display

This invocation will only work with UC20 and beyond images. Legacy UC16 and UC18
images are not supported.

Currently, only amd64 EFI images are supported. 

Supported snap configuration:
  - `default.gui` - whether or not to use a virtualized display when using the default invocation (`uc-image` with no additional command). supported options: `true`,`false` (defaults to `true`)
  - `default.ssh-host-port` - the default host port to be forwarded to port 22 on the created VM (defaults to 8022). This can also be overridden on a per-invocation basis with the `--ssh-port` command line flag.
  - `smp` - the number of CPUs to give the created VMs (defaults to 2)
  - `mem` - the amount of memory to give the created VMs (defaults to 2048)

## Installation

On [a system that supports Snap packages](https://snapcraft.io/docs/installing-snapd), run `snap install uc-launch`.
## Building

There are several configurations of build environments which *could* work. The recommended one is as follows:

Requires an Ubuntu system, [Snapcraft 7+](https://snapcraft.io/snapcraft), and [an initialized installation of LXD](https://snapcraft.io/docs/build-on-lxd).

Simply run `snapcraft`.
