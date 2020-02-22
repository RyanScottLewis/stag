# TODO

* Use `colorize` stdlib?
* Rename `CreateDirectory` to `CreateTagDirectory`
* Rename `Target` to `Source`
* Adapters for GenerateFilesystemManifest
  * Allow `find PATH -type d -or -type s` as an alternative which is ~3-4x faster
* Transactions
  * Command operations should have a `forward` and `back` methods (or something) like a Rails migration
* Creation/Deletion order of operations
  * When creating, create directories before links
  * When deleting, remove links before directories
* Configuration files
  * Strategy 1
    * Heirarchical merging:
      * `/etc/xdg/stag/config.yml`
      * `~/.config/stag/config.yml`
    * `--config` option reads from given config file path only?
  * Strategy 2
    * `--config` accepts a path delimiter (`;`) and are merged left to right
      * Default: `/etc/xdg/stag/config.yml;~/.config/stag/config.yml`
      * Example: `--config '/etc/xdg/stag/config.yml;my-config.yml'`
* CLI commands:
  ```sh
  ## Show all tags
  $ stag [list|index]

  ## Create a tag/source
  ## Name is assumed to be the current filename if not given with `--name` or  `-n`.
  ## Tags are found or created if not found recursively
  ## No tag given will assume top level I.E. `/`
  $ stag create|add|new REAL_PATH [--name NAME] [--tags TAGS_COMMA_DELIMITED]
  $ stag create|add|new REAL_PATH --name 'My Cool Thing' --tags Electronics/Projects,Programming/Projects

  ## Show a tag/source
  $ stag read|view TAG_OR_SOURCE_VIRTUAL_OR_REAL_PATH

  ## Edit a tag/source
  $ stag update|edit TAG_OR_SOURCE_VIRTUAL_OR_REAL_PATH [--path PATH] [--name NAME]

  ## Remove a tag/source
  $ stag destroy|delete TAG_OR_SOURCE_VIRTUAL_OR_REAL_PATH
  ```
* CLI options
  * An option to NOT remove items in the root path when synchronizing.
    For example if I keep other items in my root path, I don't want those items being removed on the
    next synchronization.

# BUGS

* Orphan sources (without tags) should get created at the top-level in `@options.root`.
  * This is because the virtual filesystem discovers sources **through** tags, instead of gathering
    tags through sources. Technically, both should be retrieved at the same time.

