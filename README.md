# stag

File**s**ystem **tag**s.

Hierarchically tag filesystem entries and generate/synchronize a filesystem hierarchy of directories
and symlinks based on the entries and tags.

The difference between the virtual filesystem and actual filesystem is calculated and only the
changes are applied when synchronizing.

## Example

> Note: **The CLI is not complete yet and this example is purely hypothetical until this notice is
> removed.**

```sh
$ pwd
/home/dg/Stuff

$ ls -al
drwxr-xr-x 5 dg dg 4096 Feb 21 20:05 mcu_project
drwxr-xr-x 5 dg dg 4096 Feb 21 20:05 raspi_project

$ stag create mcu_project --tags Electronics/Projects,Programming/Projects

$ stag create raspi_project --tags Electronics/Projects,Linux

$ ls -alR ~/.local/share/stag # This is the default stag root path, configurable via CLI arguments and/or config file
./Electronics:
total 4
drwxr-xr-x 2 dg dg 4096 Feb 21 19:36 Projects

./Electronics/Projects:
total 0
lrwxrwxrwx 1 dg dg 29 Feb 21 19:36 mcu_project -> /home/dg/Stuff/mcu_project
lrwxrwxrwx 1 dg dg 31 Feb 21 19:36 raspi_project -> /home/dg/Stuff/raspi_project

./Linux:
total 0
lrwxrwxrwx 1 dg dg 31 Feb 21 19:28 raspi_project -> /home/dg/Stuff/raspi_project

./Programming:
total 4
drwxr-xr-x 2 dg dg 4096 Feb 21 19:24 Projects

./Programming/Projects:
total 0
lrwxrwxrwx 1 dg dg 29 Feb 21 19:24 mcu_project -> /home/dg/Stuff/mcu_project
```

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/stag/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ryan Scott Lewis](https://github.com/your-github-user) - creator and maintainer
