
# Dalliance.jl

This a Julia interface to the [Dalliance](http://www.biodalliance.org/) genome
browser. It's designed to allow full featured visualization of genomic data
within the comfort of a [Jupyter](https://jupyter.org/) notebook.

It works by converting [Bio.jl](https://github.com/BioJulia/Bio.jl) structures
to the efficient indexed formats [BigBed and
BigWig](https://genome.ucsc.edu/FAQ/FAQformat.html#format1.5), which are kept in
memory and served as needed to the browser front-end.

## Status

This is a proof of concept. Don't expect it to work consisently or the API to
remain stable.

It relies on incomplete and unmerged features of Bio.jl, so in order to use this
package, you need to be on the work-in-progress [bigbed
branch](https://github.com/dcjones/Bio.jl/tree/bigbed) of dcjones' fork.

As a teaser, here's the kind of thing you can do with this:
![Jupyter Screenshot](http://homes.cs.washington.edu/~dcjones/dalliance.png)


