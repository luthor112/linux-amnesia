# linux-amnesia
Trying to induce temporary amnesia in Linux

The script uses `ramfs`, `unionfs-fuse` and `pivot_root` to try and induce temporary amnesia in Linux.
Based on [S01a-unionfs-live-cd.sh](https://github.com/rpodgorny/unionfs-fuse/blob/master/examples/S01a-unionfs-live-cd.sh) by Bernd Schubert.

Not tested much. Known problems:
- WSL2 won't open new sessions (the current one still works), you can kill it using `wsl --shutdown`
- Original filesystem is still available through /oldroot and other means