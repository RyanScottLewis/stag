# stag

File**s**ystem **tag**s.

Hierarchically tag filesystem entries and generate/synchronize a filesystem hierarchy of directories
and symlinks based on the tagged entries.

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

$ stag create mcu_project --name "MCU Project" --tags Electronics/Projects,Programming/Projects

$ stag create raspi_project --name "Raspberry Pi Project" --tags Electronics/Projects,Linux


$ tree ~/.local/share/stag/fs                                                                                                                                                                                                                             Insert zsh 1 master 2020-02-29 10:44 PM
/home/ryguy/.local/share/stag/fs
├── Electronics
│   └── Projects
│       ├── MCU Project -> /home/ryguy/Stuff/mcu_project
│       └── Raspberry Pi Project -> /home/ryguy/Stuff/raspi_project
├── Linux
│   └── Raspberry Pi Project -> /home/ryguy/Stuff/raspi_project
└── Programming
    └── Projects
        └── MCU Project -> /home/ryguy/Stuff/mcu_project

5 directories, 5 files
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
