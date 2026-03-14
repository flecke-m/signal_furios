# Signal UT

**Signal Desktop for FuriOS based on Ubuntu Touch with responsive design**  

---

## ⚠️ Important - Alpha State

Signal UT is currently in **alpha**. Please read the limitations and usage notes carefully before using it.

Removing libnotify changes to make notifications work on FuriOS

---

## 🔨 Build Instructions

### Ubuntu Touch Click Package (Standard - Confined)

```bash
clickable build --arch arm64
```

### Debian Package

To build a Debian package for arm64 (compatible with Debian 13 Trixie and similar):

1. Ensure you have the build dependencies installed on your system:

   ```bash
   sudo apt update
   sudo apt install debhelper-compat build-essential git jq curl python3 python3-pip libudev-dev dpkg moreutils libssl-dev libsqlite3-dev libcrypto++-dev libsqlcipher-dev npm git-lfs execstack imagemagick librsvg2-bin xauth xvfb dh-sequence-gir docbook-xsl-ns gi-docgen xmlto meson qemu-user-static tree patchelf libgtk-3-dev libgtk2.0-dev libmaliit-glib-dev libmaliit-glib2 libgirepository1.0-dev
   ```

2. Clone or ensure you have the repository:

   ```bash
   git clone https://github.com/your-repo/SignalFuriOS.git
   cd SignalFuriOS
   ```

3. Build the Debian package:

   ```bash
   dpkg-buildpackage -us -uc -a arm64
   ONFIG_SITE=/etc/dpkg-cross/cross-config.arm64     DEB_BUILD_OPTIONS=nocheck     dpkg-buildpackage --host-arch amd64 -Pcross,nocheck

   ```

   This will:
   - Run the build.sh script to compile Signal Desktop and additional components
   - Package everything into a .deb file in the parent directory

4. The resulting package will be `signalut_7.86.0-1_arm64.deb` (version may vary).

**Note:** Building requires cross-compilation for arm64, so qemu-user-static is used. Ensure your system supports it.
