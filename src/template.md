# EasyBootstrap

## Introduction

This is EasyBootstrap, a minimal BASIC tool to transfer a program
file from PC to a Commodore 64/128 disk drive.

## Website, Repository and Issue Tracker

EasyFlash website: https://skoe.de/easyflash/

Official repository and issue tracker:
https://gitlab.com/easyflash/easybootstrap.

Other EasyFlash related repositories:
https://gitlab.com/easyflash/

Source repository mirror:
https://github.com/easyflash-mirror/easybootstrap/.

## License

(C) Thomas 'skoe' Giesel

Refer to [LICENSE.md](./LICENSE.md).

## Usage

Sometimes you have your Commodore 64 with a disk drive, a freshly built EasyFlash 3,
possibly without any or just ancient software on it and a PC. But no means to get
data to your C64 and thus no chance to get it all running.

This is when EasyBootstrap comes into play.

It is a small BASIC program you can enter into your Commodore 64, save it to disk (just as a backup, you don't want to enter it twice).It can use a bare USB connection to transfer a program:

PC ➡️ USB ➡️ EasyFlash 3 ➡️ Commodore 64 ➡️ Disk Drive

The only thing it needs is an EasyFlash (works even without software on it) and a correctly inititalized CPLD and FTDI-Chip.

Use it to copy the latest EasyProg to a disk, which will be the starting point to initialize the rest.

These are the steps needed:

1.  Make sure you have the latest CPLD core. If in doubt, update
    it by following the guide on the bottom part of that page:
    https://skoe.de/easyflash/ef3update/. Make sure to put the jumpers
    back to the *DATA* position.
2.  Use the *SPECIAL* button to enter BASIC. Don't worry if your
    Commodore 64 screen remains black or shows garbage if there is no
    software on the EasyFlash 3, the *SPECIAL* button will work if the
    CPLD is configured correctly.
3.  You can check whether your EasyFlash 3 is active with the command shown
    in the following screenshot. It must always print the encoded version
    number of the CPLD, for 1.1.1 it must show `73`
    (73 = $49 = 01.001.001 = 1.1.1).
    Try it several times, the number must not change.

    ![Screenshot: CPLD Check](images/cpld-check.png "Screenshot: CPLD Check")

4.  Enter listing of EasyBootstrap exactly as shown below. Double-check
    everything.
5.  Save it to disk:

    `SAVE"EASYBOOTSTRAP",8`

    Remember that Commodore 64 drives do not overwrite files by default.
    If you need to replace a file, either delete it before saving or chose
    another name.
6.  Download [EasyTransfer](https://skoe.de/easyflash/downloads/) and the
    program you want to transfer, e.g.,
    [EasyProg](https://skoe.de/easyflash/downloads/).
7.  Make sure there is a disk in your drive with enough space for the
    program. Run *EasyBootstrap* on your Commodore 64 and enter a file
    name for the program to be transfered.
8.  Connect the USB cable and send the file from the PC using
    *EasyTransfer* as described
    [there](https://skoe.de/easyflash/usbfiletransfer/) in section
    *Starting single-load programs with EasyTransfer*. Yes, it will not
    be started, but written to disk. You must use the "Start PRG" tab
    nevertheless.

    * Alternatively you can use the command line program
      `ef3xfer -x foo.prg`.

9.  If the EasyTransfer reports success and the Commodore 64 side
    looks like in the image below, everything worked fine.

    ![Screenshot: Transfer Successful](images/success.png "Screenshot: Transfer Success")

10. Yay! Now you can load the new program from disk as usual.
    With this, e.g., you can
    [update or initialize your EasyFlash 3 menu](https://skoe.de/easyflash/ef3update/).


## The Source Code

Enter it line by line, exactly as written here, including line numbers.
Confirm every line with &lt;RETURN&gt;.

To show the whole program, use `LIST`. By holding down &lt;CTRL&gt;
after &lt;RETURN&gt;, you can slow the output down, with
&lt;RUN/STOP&GT; you can stop it.

A single line can be listed by its number, e.g., `LIST 42` &lt;RETURN&gt;.
To correct a line, list it, edit it and confirm it again with
&lt;RETURN&gt;. Or enter it again. The new line will replace the old line
with the same number. To erase a line, enter its number but no content
and press &lt;RETURN&gt;.

The lines are ordered by their numbers automatically,
independently from the order you enter them.

```
{src}
```

## Build Dependencies

The output file of this project is this `README.md`. To build it,
the following is needed:

- Bash
- Python 3
- Vice emulator for `petcat`
- ACME assembler

Just run `./build.sh`
