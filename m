#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
OUT=../out
TOOLPATH=../rkbin/tools
BOARD=$1

PATH=$PATH:$TOOLPATH

#make rockchip_linux_defconfig
make -j16 BL31=../rkbin/bin/rk35/rk3568_bl31_v1.32.elf spl/u-boot-spl.bin u-boot.dtb u-boot.itb

./tools/mkimage -n rk3568 -T rksd -d ../rkbin/bin/rk35/rk3566_ddr_1056MHz_v1.10.bin:spl/u-boot-spl.bin idbloader.img

cp u-boot.itb ${OUT}/u-boot/
cp idbloader.img ${OUT}/u-boot/
cp ../rkbin/bin/rk35/rk356x_spl_loader_ddr1056_v1.10.111.bin ${OUT}/u-boot/

cp u-boot.itb idbloader.img /mnt/d/d
