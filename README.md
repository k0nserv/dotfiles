# Dead Simple dotfiles

Sync and symlink. That's it

Everything ending in `.symlink` in the `files` folder is symlinked to your 
home directory with a `.` append to the file name and the extension removed.

## Example

```bash
$ rake sync
```

To override existing files use

```bash
$ OVERRIDE_SYMLINKS=true rake sync
```

## LICENSE

MIT(See LICENSE.md)
