echo "This will install Windows Server 2019 setup an emulator with accelerated graphics to enable playing games.";
read -p 'Create Windows Disk Container? Y' ready;
case $ready in
	Y) qemu-img create -f qcow2 win.qcow2 100G;
esac
read -p 'Download Windows Server 2019 180 Days Trial iso directly from Microsoft? Y' ready;
case $ready in
	Y) xterm -e wget -O win2019.iso https://is.gd/winserver2019;
esac
read -p 'Compile QEmu? Y' ready;
case $ready in
	Y) sudo xterm -e sudo apt update && sudo apt install libusb-ocaml-dev libusb-0.1-4 libusb-1.0-0-dev libusbredirhost-dev libvirglrenderer-dev libcap-ng-dev libattr1-dev libblockdev-mpath2-dev libblockdev-utils-dev fence-agents resource-agents -y && git clone https://github.com/qemu/qemu.git && sudo xterm -e ./configure --enable-system --enable-user --enable-linux-user --enable-guest-agent --enable-guest-agent-msi --enable-gnutls --enable-auth-pam --enable-gcrypt --enable-sdl --enable-vte --enable-curses --enable-iconv --enable-vnc --enable-vnc-jpeg --enable-virtfs --enable-mpath --enable-xen --enable-curl --enable-kvm --enable-rdma --enable-pvrdma --enable-spice --enable-usb-redir --enable-libusb --enable-coroutine-pool --enable-libssh --enable-virglrenderer --enable-tools && sudo xterm -e make -j8 && sudo xterm -e sudo make install&
esac
read -p 'Run QEmu? Y' ready;
case $ready in
	Y) sudo pkill qemu;
	echo 'To connect IP is 127.0.0.1 5900 SPICE protocol VNC is 127.0.0.1 99' && sudo qemu-system-x86_64  -hda win.qcow2 -m 3064M -cdrom win2019.iso -cpu host,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff -smp 4,cores=1,threads=2 -enable-kvm -vnc :99 -usb -overcommit mem-lock=on -net nic,model=virtio -net user,hostfwd=tcp::3389-:3389,hostfwd=tcp::22-:22,hostfwd=udp::3658-:3658 -no-user-config -nodefaults -rtc base=localtime -no-hpet -no-shutdown -boot strict=on -chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0 -k en-us -device qxl-vga,id=video0,ram_size=67108864,vram_size=67108864,vram64_size_mb=67108864,vgamem_mb=2047,max_outputs=1 -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x6 -msg timestamp=on -soundhw hda -spice port=5900,addr=127.0.0.1,disable-ticketing && vinagre && echo 'I hope you liked my script please follow me on https://github.com/independentcod';
esac
