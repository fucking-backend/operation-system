### 实验步骤

```sh
# 生产虚拟硬盘
dd bs=512 if=/dev/zero of=hd.img count=204800

# 格式化虚拟硬盘
# （1） 把虚拟硬盘文件变成 Linux 下的回环设备，让 Linux 以为这是个设备
sudo losetup /dev/loop8 hd.img
# （2） mkfs.ext4 命令格式化这个 /dev/loop0 回环块设备，在里面建立 EXT4 文件系统。
sudo mkfs.ext4 -q /dev/loop8
# （3） mount 命令，将 hd.img 文件当作块设备，把它挂载到事先建立的 hdisk 目录下，并在其中建立一个 boot
sudo mount -o loop ./hd.img ./hdisk/
sudo mkdir ./hdisk/boot/

# 安装GRUB
# （1）
sudo grub-install --boot-directory=./hdisk/boot/ --force --allow-floppy /dev/loop8
# （2）/hdisk/boot/grub/ 目录下建立一个 grub.cfg 文本文件，写入内容。
sudo vim ./hdisk/boot/grub/grub.cfg

menuentry 'HelloOS' {
    insmod part_msdos
    insmod ext2
    set root='hd0' #我们的硬盘只有一个分区所以是'hd0'
    multiboot2 /boot/HelloOS.eki #加载boot目录下的HelloOS.eki文件
    boot #引导启动
}
set timeout_style=menu
if [ "${timeout}" = 0 ]; then
    set timeout=10 #等待10秒钟自动启动
fi


# 转换虚拟硬盘格式
VBoxManage convertfromraw ./hd.img --format VDI ./hd.vdi


# 安装虚拟硬盘
# （1） 配置硬盘控制器，我们使用 SATA 的硬盘，其控制器是 intelAHCI
VBoxManage storagectl HelloOS --name "SATA" --add sata --controller IntelAhci --portcount 1
# （2） 删除虚拟硬盘UUID并重新分配
VBoxManage closemedium disk ./hd.vdi 
# （3） 将虚拟硬盘挂到虚拟机的硬盘控制器
VBoxManage storageattach HelloOS --storagectl "SATA" --port 1 --device 0 --type hdd --medium ./hd.vdi

# 启动虚拟机
VBoxManage startvm HelloOS
```

### 遇到的问题

1. 运行sudo losetup /dev/loop0 hd.img

failed to set up loop device: Device or resource busy

df -h 找个没有被占用的，接着来

https://askubuntu.com/questions/1243020/losetup-raspbian-20200505-img-failed-to-set-up-loop-device-device-or-resource

sudo losetup /dev/loop6 hd.img

sudo mkfs.ext4 -q /dev/loop6 这一步和上一步loop设备号保持一致

2. sudo grub-install --boot-directory=./hdisk/boot/ --force --allow-floppy /dev/loop6

Installing for i386-pc platform.
grub-install: warning: File system `ext2' doesn't support embedding.
grub-install: warning: Embedding is not possible.  GRUB can only be installed in this setup by using blocklists.  However, blocklists are UNRELIABLE and their use is discouraged..
Installation finished. No error reported

3. VBoxManage startvm HelloOS

Waiting for VM "HelloOS" to power on...
VBoxManage: error: Could not open the medium '/home/ubuntu/hd.vdi'.
VBoxManage: error: VD: error VERR_FILE_NOT_FOUND opening image file '/home/ubuntu/hd.vdi' (VERR_FILE_NOT_FOUND)
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component MediumWrap, interface IMedium

4. VBoxManage storagectl HelloOS --name "SATA" --add sata --controller IntelAhci --portcount 1

VBoxManage: error: Storage controller named 'SATA' already exists
VBoxManage: error: Details: code VBOX_E_OBJECT_IN_USE (0x80bb000c), component SessionMachine, interface IMachine, callee nsISupports
VBoxManage: error: Context: "AddStorageController(Bstr(pszCtl).raw(), StorageBus_SATA, ctl.asOutParam())" at line 1080 of file VBoxManageStorageController.cpp

5. 卡了很久，可以看到GRUB，但看不到*HelloOS

grub.cfg文本文件中的“set root”值有问题

6. #删除虚拟硬盘UUID并重新分配 

VBoxManage closemedium disk ./hd.vdi 

VirtualBox报错：

Failed to open the medium with following ID: {eb256795-0c83-45b9-9d97-f26612934f03}.

The given path '{eb256795-0c83-45b9-9d97-f26612934f03}' is not fully qualified.

Result Code: VBOX_E_FILE_ERROR (0x80BB0004)
Component: MediumWrap
Interface: IMedium {ad47ad09-787b-44ab-b343-a082a3f2dfb1}
Callee: IVirtualBox {d0a0163f-e254-4e5b-a1f2-011cf991c38d}
Callee RC: VBOX_E_OBJECT_NOT_FOUND (0x80BB0001)

7. sudo rm -rf ./*
rm: cannot remove './hdisk': Device or resource busy

sudo umount ./hdisk
