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

