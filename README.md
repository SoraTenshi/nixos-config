# My NixOS Configuration
A collection of my (hopefully) growing NixOS Config

Shoutout to:
- @CRTified for introducing me to it :)

- [Wil T](https://www.youtube.com/channel/UCLsaznoh7qsE8sc3XQurubw) as he posts a lot of helpfule videos about Nix(OS) and also is essentially
the reason i could write this tutorial.

## Installation from Live-CD
Since my brain is very wonky, i rather want to type this down so that in the case, 
when i actually want to swap permanently to Linux (from Windows) i am able to reproduce my full system.

### Step 1: Partition drives.

I would do it the following way:

Set-up the main (boot) partition as GPT (EFI) which has 2 partitions as follows:

`/dev/sda1` as boot drive which is +~ 200M in size and formatted as `FAT32`
`/dev/sda2` as 'rest' drive, formatted as `ext4`

Hint: using `lsblk` shows your connected drives.

To do this, i preferr using `fdisk`. 

### Step 2: Formatting

Simple enough, there is an easy formular to do that:

```sh
$ sudo mkfs.fat -F 32 /dev/sda1
$ sudo fatlabel /dev/sda1 NIXBOOT
$ sudo mkfs.ext4 /dev/sda2 -L NIXMAIN
```

The names are as simply described within /nixos-config/nixos/hardware-configuration.nix

### Step 3: Mounting

Straight forward process.

```sh
$ sudo mount /dev/disk/by-label/NIXMAIN /mnt
$ sudo mkdir /mnt/boot
$ sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
```

### Step 4: Swapfile

Also very easy to understand, a swapfile is essentially 'extended memory' where the CPU can use the size of the 
swapfile as extra Memory once its space runs out.

```sh
$ sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=2097152
$ sudo chmod 600 /mnt/.swapfile
$ sudo mkswap /mnt/.swapfile
```

Now this is a bit more interesting.

To have a better overview of what the `dd` command does: `if` can be unfolded to 'infile' so what i want to use to write the file with.
`/dev/zero` is just zeros as the name implies.

`of` is the target 'outfile'

`bs=1024` is the 'blocksize'

`count=2097152` is a magic number, esentially blocksize and count will be multiplied together, to get the final size of the swapfile. 
Multiplying those numbers together will get you around `2GiB`.

### Step 5: Actual configuration

This process is also straight forward:

```sh
$ sudo nixos-generate-config --root /mnt
```

From here, this repository takes over.

**However**: Do **NOT** overwrite the `hardware-configuration.nix` but rather use the one in this repository as some kind of template.

Once everything is done, the fun part begins:

```sh
$ sudo nixos-install
```

And that's essentially it. 

After some time you will most likely be prompted to type in a new `superuser` password, just type in the actual password and that's it for the standard configuration.

### Step 6: Home-Manager

Just add the Home-Manager to your `nix-channel` and let it do the magic.

```sh
$ sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-[your-nixos-version].tar.gz home-manager
$ sudo nix-channel --update
```

For more information regarding the Home-Manager, [use this Link](https://nix-community.github.io/home-manager/index.html)
