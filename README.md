# ssh-jump

Simple rootless cloud-friendly public-crypto SSH Jump Server image.

## Why

Sometimes you need to connect locally to a remote server that is only accessible via your Docker deployment or Kubernetes cluster.
This image runs as a non-root user and only allows SSH connections using pre-configured public key, so it is usable in environments with decent security policies.

**I am not claiming this image to be a secure solution for long term use in any way.**

**Use at your own risk. All code is provided as-is with no guarantees.**

## How to use:

1. Copy the manifest from `/examples/deployment.yaml` and set your SSH to the `USER_PUBLIC_KEY` environment variable in the deployment.
2. Apply the manifest.
3. Port-forward via kube-proxy, i.e. `kubectl port-forward pods/ssh-jump 2222:22`.
4. Use SSH to connect to desired remote server via the jump server, i.e. `ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -L <local-port>:<remote-ip>:<remote-port> jump@localhost -p 2222`. 
   The server re-generates its ssh keys after every restart, the extra options ensure that the key won't be saved in ~/.ssh/known_hosts as you'd have to remove it manually after each pod restart. 
5. Use `localhost@<local-port>` to connect to the remote server.
6. Enjoy!
