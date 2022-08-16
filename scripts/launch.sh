#!/bin/sh

QEMU=qemu-system-x86_64

SMP="$(snapctl get default.smp)"
MEM="$(snapctl get default.mem)"
HOSTPORT="$(snapctl get default.ssh-host-port)"

default_gui() {
    case "$(snapctl get default.gui)" in
        "true")
            echo ""
            ;;
        "false")
            echo "-nographic"
            ;;
        *)
            echo "Internal error: impossible value for default.gui"
            exit 1
            ;;
    esac
}

help() {
    echo "Usage: $SNAP_INSTANCE_NAME[.command] [--ssh-port <port number>] <ubuntu-core.img>"
    exit 1
}

case "$1" in
    "--no-gui")
        GUIARG="-nographic"
        ;;
    "--gui")
        GUIARG=""
        ;;
    "--default-gui")
        GUIARG="$(default_gui)"
        ;;
    *)
        echo "Internal error: impossible gui setting"
        exit 1
        ;;
esac
shift

case "$1" in
    "--ssh-port")
        HOSTPORT="$2"
        shift 2
        ;;
    "--help" | "-h")
        help
        ;;
esac

if [ -z "$1" ]; then
    help
fi

$QEMU                                                                                               \
    -smp "$SMP"                                                                                     \
    -m "$MEM"                                                                                       \
    -net nic,model=virtio                                                                           \
    -net user,hostfwd=tcp::"$HOSTPORT"-:22                                                          \
    -drive file=$SNAP/usr/share/OVMF/OVMF_CODE.fd,if=pflash,format=raw,unit=0,readonly=on           \
    -drive file="$1",cache=none,format=raw,id=disk1,if=none                                         \
    -device virtio-blk-pci,drive=disk1,bootindex=1                                                  \
    -machine accel=kvm                                                                              \
    $GUIARG
