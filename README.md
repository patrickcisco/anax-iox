
## Alpine 3.7 Base Image
This is an alpine linux guest os that contains the docker daemon. Customers can use this image as a basis for deploying their own docker applications within the current standard IOx KVM infrastructure. 

For more information on Cisco IOx Application Development, refer to the wiki:
https://developer.cisco.com/docs/iox/#introduction-to-iox/introduction-to-iox

## Running the Alpine 3.7 image with qemu
To run the base image with qemu, you can run the following command (This is being ran inside of an ubuntu VM with qemu installed and a KVM hypervisor). 
```
qemu-system-x86_64  -netdev "user,id=user.0,hostfwd=tcp::3563-:22" \
                    -vnc "127.0.0.1:35" \
                    -m "512M" \
                    -device "virtio-net,netdev=user.0" \
                    -device "virtio-rng-pci,rng=objrng0,id=rng0,bus=pci.0,addr=0x10" \
                    -display "none" \
                    -machine "type=pc,accel=kvm" \
                    -name "alpine37-docker.v1.0.qcow2" \
                    -boot "once=d" \
                    -object "rng-random,id=objrng0,filename=/dev/urandom" \
                    -drive "file=images/alpine37-docker.v1.0.qcow2,if=virtio,cache=writeback,discard=ignore,format=qcow2"
```

You can then ssh into the base image
```
## password is cisco
ssh -p 3563 root@localhost
```
