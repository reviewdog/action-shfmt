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
    default: '-i 2 -ci'
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
      - uses: actions/checkout@ee0669bd1cc54295c223e0bb666b733df41de1c5 # v2.7.0
      - uses: reviewdog/action-shfmt@d8f080930b9be5847b4f97e9f4122b81a82aaeac # v1.0.4
```
