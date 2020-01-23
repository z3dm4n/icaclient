# Citrix ICA-Client

## 0. Prep

Download the client and put it into this repo.

Download URL:
https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html

## 1. Build

As usual:

       docker build --rm --force-rm -t z3dm4n/icaclient .

## 2. Use

Since it is a X11 GUI software, usage is in two steps:

  1. Run a background container as server (only required once).

        `docker run -d --name icaclient z3dm4n/icaclient`

  2. Connect to the container using `ssh -X` (as many times you want).
     Logging in with `ssh` automatically opens a Firefox window

        `ssh -X ff@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' icaclient)`

  3. Browse to your Citrix service and open the .ica file "with" `/opt/Citrix/ICAClient/wfica.sh`.

You can configure Firefox and set bookmarks. As long as you don't remove the container and you reuse the same container, all your changes persist. You could also tag and push your configuration to a registry to backup (should be your own private registry for your privacy).
