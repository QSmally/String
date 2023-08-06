
# String

> A tool to easily perform actions on strings.

Commit HEAD compiled with Zig `0.10.1`.

## Commands

* `string md5 <string>`: generate an md5 hash on `<string>`;
* `string e64 <string>`: encode into a base-64 string;
* `string d64 <string>`: decode from a base-64 string.

**Bash pipes**

* `cat codings | string d64`
* `grep . -name '??-' | string md5`
