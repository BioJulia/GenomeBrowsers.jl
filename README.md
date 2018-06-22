# GenomeBrowsers.jl

[![latest release](https://img.shields.io/github/release/BioJulia/Dalliance.jl.svg?style=flat-square)](https://github.com/BioJulia/GenomeBrowsers.jl/releases/latest)
[![MIT license](https://img.shields.io/badge/license-MIT-green.svg?style=flat-square)](https://github.com/BioJulia/GenomeBrowsers.jl/blob/master/LICENSE)
[![stable documentation](https://img.shields.io/badge/docs-stable-blue.svg?style=flat-square)](https://biojulia.github.io/GenomeBrowsers.jl/stable)
[![latest documentation](https://img.shields.io/badge/docs-latest-blue.svg?style=flat-square)](https://biojulia.github.io/GenomeBrowsers.jl/latest/)
![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg?style=flat-square)
[![Chat on Discord](https://img.shields.io/badge/discord-chat-blue.svg?style=flat-square&logo=discord&colorB=%237289DA)](https://discord.gg/z73YNFz)


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
| [![julia06](http://pkg.julialang.org/badges/GenomeBrowsers_0.6.svg?style=flat-square)](http://pkg.julialang.org/?pkg=GenomeBrowsers) [![julia07](http://pkg.julialang.org/badges/GenomeBrowsers_0.7.svg?style=flat-square)](http://pkg.julialang.org/?pkg=GenomeBrowsers) | [![travis](https://img.shields.io/travis/BioJulia/GenomeBrowsers.jl/master.svg?label=Linux+/+macOS)](https://travis-ci.org/BioJulia/GenomeBrowsers.jl) [![appveyor](https://ci.appveyor.com/api/projects/status/klkynmkr1tgd30gq/branch/master?svg=true)](https://ci.appveyor.com/project/Ward9250/genomebrowsers-jl/branch/master) [![coverage](http://codecov.io/github/BioJulia/GenomeBrowsers.jl/coverage.svg?branch=master)](http://codecov.io/github/BioJulia/GenomeBrowsers.jl?branch=master) |


## Contributing

We appreciate contributions from users including reporting bugs, fixing
issues, improving performance and adding new features.

Take a look at the [CONTRIBUTING](CONTRIBUTING.md) file provided with
every BioJulia package package for detailed contributor and maintainer
guidelines.


### Financial contributions

We also welcome financial contributions in full transparency on our
[open collective](https://opencollective.com/biojulia).
Anyone can file an expense. If the expense makes sense for the development
of the community, it will be "merged" in the ledger of our open collective by
the core contributors and the person who filed the expense will be reimbursed.


## Backers & Sponsors

Thank you to all our backers and sponsors!

Love our work and community? [Become a backer](https://opencollective.com/biojulia#backer).

[![backers](https://opencollective.com/biojulia/backers.svg?width=890)](https://opencollective.com/biojulia#backers)

Does your company use BioJulia? Help keep BioJulia feature rich and healthy by
[sponsoring the project](https://opencollective.com/biojulia#sponsor)
Your logo will show up here with a link to your website.

[![](https://opencollective.com/biojulia/sponsor/0/avatar.svg)](https://opencollective.com/biojulia/sponsor/0/website)
[![](https://opencollective.com/biojulia/sponsor/1/avatar.svg)](https://opencollective.com/biojulia/sponsor/1/website)
[![](https://opencollective.com/biojulia/sponsor/2/avatar.svg)](https://opencollective.com/biojulia/sponsor/2/website)
[![](https://opencollective.com/biojulia/sponsor/3/avatar.svg)](https://opencollective.com/biojulia/sponsor/3/website)
[![](https://opencollective.com/biojulia/sponsor/4/avatar.svg)](https://opencollective.com/biojulia/sponsor/4/website)
[![](https://opencollective.com/biojulia/sponsor/5/avatar.svg)](https://opencollective.com/biojulia/sponsor/5/website)
[![](https://opencollective.com/biojulia/sponsor/6/avatar.svg)](https://opencollective.com/biojulia/sponsor/6/website)
[![](https://opencollective.com/biojulia/sponsor/7/avatar.svg)](https://opencollective.com/biojulia/sponsor/7/website)
[![](https://opencollective.com/biojulia/sponsor/8/avatar.svg)](https://opencollective.com/biojulia/sponsor/8/website)
[![](https://opencollective.com/biojulia/sponsor/9/avatar.svg)](https://opencollective.com/biojulia/sponsor/9/website)


## Questions?

If you have a question about contributing or using BioJulia software, come
on over and chat to us on [Discord](https://discord.gg/z73YNFz), or you can try the
[Bio category of the Julia discourse site](https://discourse.julialang.org/c/domain/bio).

[Bio category of the Julia discourse site](https://discourse.julialang.org/c/domain/bio).