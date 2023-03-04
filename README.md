
# String

> A tool to easily perform actions on strings.

### Actions

* `string md5 <string>`: generate an md5 hash on `<string>`;
* `string e64 <string>`: encode into a base-64 string;
* `string d64 <string>`: decode from a base-64 string.

### Pipes

* `cat codings | string d64`
* `grep . -name '??-' | string md5`
