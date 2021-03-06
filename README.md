# fast disk log

__Author:__ Louis-Philippe Gauthier.

Pool-based asynchronous Erlang disk logger

[![Build Status](https://travis-ci.org/lpgauth/fast_disk_log.svg?branch=master)](https://travis-ci.org/lpgauth/fast_disk_log)

### Requirements

* Erlang 16.0 +

### Environment variables

<table width="100%">
  <theader>
    <th>Name</th>
    <th>Type</th>
    <th>Default</th>
    <th>Description</th>
  </theader>
  <tr>
    <td>max_delay</td>
    <td>pos_integer()</td>
    <td>2000</td>
    <td>maximum delay time before flush to writer</td>
  </tr>
  <tr>
    <td>max_size</td>
    <td>pos_integer()</td>
    <td>8000000</td>
    <td>maximum buffer size before flush to writer</td>
  </tr>
</table>

## API
<a href="http://github.com/lpgauth/fast_disk_log/blob/master/doc/fast_disk_log.md#index" class="module">Function Index</a>

## Examples

```erlang
1> fast_disk_log_app:start().
ok

2> fast_disk_log:open(<<"2015-05-13-14">>, <<"2015-05-13-14.json">>, [{pool_size, 8}]).
ok

3> fast_disk_log:log(<<"2015-05-13-14">>, <<"{\"key\": \"value\"}\n">>).
ok

4> fast_disk_log:sync(<<"2015-05-13-14">>).
ok

5> fast_disk_log:close(<<"2015-05-13-14">>).
ok

6> fast_disk_log:log(<<"2015-05-13-14">>, <<"{\"key\": \"value\"}\n">>).
{error,no_such_log}
```

## Tests

```makefile
make eunit
make build-plt && make dialyze
make xref
```

## License

```license
The MIT License (MIT)

Copyright (c) 2015 Louis-Philippe Gauthier

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
