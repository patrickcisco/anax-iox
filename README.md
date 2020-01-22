
## Alpine 3.7 Base Image
This is an alpine linux guest os that contains the docker daemon. Customers can use this image as a basis for deploying their own docker applications within the current standard IOx KVM infrastructure. 
Download the tar file from
https://devhub.cisco.com/artifactory/list/iox-packages/apps/alpine-docker-vm/x86/alpine37-docker.v1.0.tar and extract the qcow2 file and place it in images/

```
➜  anax-iox (master) ✔ tree -L 2 images 
images
├── alpine37-docker.v1.0.qcow2
└── sha256.txt
```

Verify the SHA matches

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

## Containerizing anax
Inside of the anax folder, there are a few files to help in building a docker image for anax. One that is not included is the .crt file needed to connect to the openhorizon cloud. You'll supply your own.

```
➜  anax (master) ✗ tree   
.
├── Dockerfile
├── Makefile
├── forcisco.crt
└── horizon.cfg
```

They are 3 environment variables needed for this docker image to be built correctly. They are
```
CLUSTER_ID
HZN_EXCHANGE_USER_AUTH
HZN_EXCHANGE_NODE_AUTH
```
Once those environment variables are set, you can build the container.

```
cd anax
make build
```

## Building your IOx application

To build the IOx application from the qcow2 image, you can leverage the ioxclient tool [https://developer.cisco.com/docs/iox/#!what-is-ioxclient](https://developer.cisco.com/docs/iox/#!what-is-ioxclient)

```
make build 
```