# action-shfmt

[![Test](https://github.com/reviewdog/action-shfmt/workflows/Test/badge.svg)](https://github.com/reviewdog/action-shfmt/actions?query=workflow%3ATest)
[![reviewdog](https://github.com/reviewdog/action-shfmt/workflows/reviewdog/badge.svg)](https://github.com/reviewdog/action-shfmt/actions?query=workflow%3Areviewdog)
[![release](https://github.com/reviewdog/action-shfmt/workflows/release/badge.svg)](https://github.com/reviewdog/action-shfmt/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/reviewdog/action-shfmt?logo=github&sort=semver)](https://github.com/reviewdog/action-shfmt/releases)
[![action-bumpr supported](https://img.shields.io/badge/bumpr-supported-ff69b4?logo=github&link=https://github.com/haya14busa/action-bumpr)](https://github.com/haya14busa/action-bumpr)

![demo](https://user-images.githubusercontent.com/3797062/134041779-b016a9cc-efba-4191-a254-656a495cfac8.png)

Run [shfmt](https://github.com/mvdan/sh) with [reviewdog](https://github.com/reviewdog/reviewdog) and post GitHub suggestion comments on Pull Requests.


## Input

```yaml
inputs:
  github_token:
    description: 'GITHUB_TOKEN'
    default: '${{ github.token }}'
  workdir:
    description: 'Working directory relative to the root directory.'
    default: '.'
  ### Flags for reviewdog ###
  level:
    description: 'Report level for reviewdog [info,warning,error]'
    default: 'error'
  filter_mode:
    description: |
      Filtering mode for the reviewdog command [added,diff_context,file,nofilter].
      Default is added.
    default: 'added'
  fail_on_error:
    description: |
      Exit code for reviewdog when errors are found [true,false]
      Default is `false`.
    default: 'false'
  reviewdog_flags:
    description: 'Additional reviewdog flags'
    default: ''
  ### Flags for shfmt ###
  shfmt_flags:
    description: 'flags for shfmt'
    default: ''
  path:
    description: |
      Whitespace-separated files or directories for shfmt to format, relative to workdir.
      Default is '.' (every shell script under workdir).
      An empty or whitespace-only value skips shfmt. Paths are not glob-expanded.
    default: '.'
```

## Usage

```yaml
name: reviewdog
on: [pull_request]
jobs:
  shfmt:
    name: runner / shfmt
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
      - uses: reviewdog/action-shfmt@c5e3ba7497c338866921924691aef4fa18bc1fe0 # v1.1.0
```

### Format only the files a pull request changed

shfmt parses every file passed in `path`, whatever its extension, so filter the
changed files to shell scripts. When none changed, `path` is empty and shfmt is skipped.

```yaml
      - uses: tj-actions/changed-files@9426d40962ed5378910ee2e21d5f8c6fcbf2dd96 # v47.0.6
        id: changed
        with:
          files: |
            **/*.sh
            **/*.bash
      - uses: reviewdog/action-shfmt@c5e3ba7497c338866921924691aef4fa18bc1fe0 # v1.1.0
        with:
          path: ${{ steps.changed.outputs.all_changed_files }}
```
