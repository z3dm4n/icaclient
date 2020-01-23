# Citrix ICA-Client

## Build the container

### ICA-Client and License

In the `CITRIX LICENSE AGREEMENT` stored in file `LICENSE`, there is no
prohibition of distribution of the icaclient. So I suppose, I am
allowed to distribute it, as long as you follow the license
restrictions, i.e. you only use it for the Citrix products it is
intended to be used with. Therefore the icaclient is part of this
repository. So you must accept the `LICENSE` if you use this docker
container.

Otherwise, you could also download the client from:

https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html

### Build command

As usual:

       docker build --rm --force-rm -t z3dm4n/icaclient .

## Usage

Since it is a X11 GUI software, usage is in two steps:
  1. Run a background container as server (only required once).

        `docker run -d --name icaclient z3dm4n/icaclient`

  2. Connect to the container using `ssh -X` (as many times you want).
     Logging in with `ssh` automatically opens a Firefox window

        `ssh -X ff@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' icaclient)`

  3. Browse to your Citrix service and open the .ica file "with" `/opt/Citrix/ICAClient/wfica.sh`.

You can configure Firefox and set bookmarks. As long as you don't remove the container and you reuse the same container, all your changes persist. You could also tag and push your configuration to a registry to backup (should be your own private registry for your privacy).
