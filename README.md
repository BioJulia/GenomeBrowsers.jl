# GenomeBrowsers.jl

[![latest release][release-img]][release-url]
[![MIT license][license-img]][license-url]
[![stable documentation][docs-stable-img]][docs-stable-url]
[![latest documentation][docs-latest-img]][docs-latest-url]
![lifecycle][lifecycle-experimental]
[![Chat on Discord][discord-img]][discord-url]

## Description

This a Julia interface to the [Dalliance](http://www.biodalliance.org/) genome
browser. It's designed to allow full featured visualization of genomic data
within the comfort of a [Jupyter](https://jupyter.org/) notebook.

It works by converting [Bio.jl](https://github.com/BioJulia/Bio.jl) structures
to the efficient indexed formats [BigBed and
BigWig](https://genome.ucsc.edu/FAQ/FAQformat.html#format1.5), which are kept in
memory and served as needed to the browser front-end.

## Installation

Install GenomeBrowsers from the Julia REPL:

```julia
using Pkg
add("GenomeBrowsers")
#Pkg.add("GenomeBrowsers") for julia prior to v0.7
```

## Testing

GenomeBrowsers is tested against, julia `v0.6` and `0.7-dev` on Linux, OSX,
and Windows.

**Latest release** | **Latest build status** |
|:------------------:|:-----------------------:|
| [![julia06][juliapkg06-img]][juliapkg-url] [![julia07][juliapkg07-img]][juliapkg-url] | [![travis][travis-img]][travis-url] [![appveyor][appveyor-img]][appveyor-url] [![coverage][codecov-img]][codecov-url] |

## Contributing and Questions

We appreciate contributions from users including reporting bugs, fixing issues,
improving performance and adding new features.

Take a look at the [CONTRIBUTING](CONTRIBUTING.md) file provided with this
package for detailed contributor and maintainer guidelines.

If you have a question about contributing or using this package, come on over
and chat to us on [Discord][discord-url], or you can try the
[Bio category of the Julia discourse site](https://discourse.julialang.org/c/domain/bio).

[release-img]:            https://img.shields.io/github/release/BioJulia/Dalliance.jl.svg?style=flat-square
[release-url]:            https://github.com/BioJulia/GenomeBrowsers.jl/releases/latest
[license-img]:            https://img.shields.io/badge/license-MIT-green.svg?style=flat-square
[license-url]:            https://github.com/BioJulia/GenomeBrowsers.jl/blob/master/LICENSE
[docs-stable-img]:        https://img.shields.io/badge/docs-stable-blue.svg?style=flat-square
[docs-stable-url]:        https://biojulia.github.io/GenomeBrowsers.jl/stable
[docs-latest-img]:        https://img.shields.io/badge/docs-latest-blue.svg?style=flat-square
[docs-latest-url]:        https://biojulia.github.io/GenomeBrowsers.jl/latest/
[lifecycle-experimental]: https://img.shields.io/badge/lifecycle-experimental-orange.svg?style=flat-square
[lifecycle-maturing]:     https://img.shields.io/badge/lifecycle-maturing-blue.svg?style=flat-square
[lifecycle-stable]:       https://img.shields.io/badge/lifecycle-stable-brightgreen.svg?style=flat-square
[lifecycle-retired]:      https://img.shields.io/badge/lifecycle-retired-orange.svg?style=flat-square
[lifecycle-archived]:     https://img.shields.io/badge/lifecycle-archived-red.svg?style=flat-square
[lifecycle-dormant]:      https://img.shields.io/badge/lifecycle-dormant-blue.svg?style=flat-square
[lifecycle-questioning]:  https://img.shields.io/badge/lifecycle-questioning-blue.svg?style=flat-square
[discord-img]:            https://img.shields.io/badge/discord-chat-blue.svg?style=flat-square&logo=discord&colorB=%237289DA
[discord-url]:            https://discord.gg/z73YNFz
[juliapkg06-img]:         http://pkg.julialang.org/badges/GenomeBrowsers_0.6.svg?style=flat-square
[juliapkg07-img]:         http://pkg.julialang.org/badges/GenomeBrowsers_0.7.svg?style=flat-square
[juliapkg-url]:           http://pkg.julialang.org/?pkg=BioAlignments
[travis-img]:             https://img.shields.io/travis/BioJulia/GenomeBrowsers.jl/master.svg?label=Linux+/+macOS
[travis-url]:             https://travis-ci.org/BioJulia/GenomeBrowsers.jl
[appveyor-img]:           https://ci.appveyor.com/api/projects/status/klkynmkr1tgd30gq/branch/master?svg=true
[appveyor-url]:           https://ci.appveyor.com/project/Ward9250/genomebrowsers-jl/branch/master
[codecov-img]:            http://codecov.io/github/BioJulia/GenomeBrowsers.jl/coverage.svg?branch=master
[codecov-url]:            http://codecov.io/github/BioJulia/GenomeBrowsers.jl?branch=master
