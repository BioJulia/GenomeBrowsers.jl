# GenomeBrowsers.jl
# =================
# A julia package for visualising annotations through the dalliance browser.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/Dalliance.jl/blob/master/LICENSE.md

__precompile__()

module GenomeBrowsers

export genomebrowser

using HttpServer, JSON, GenomicFeatures
import HttpCommon
import Base: show

const dalliancejs = Pkg.dir("GenomeBrowsers", "data", "dalliance-compiled.js")

include("server.jl")
include("data_preparation.jl")
include("supported_genomes.jl")
include("browser.jl")

"""
    genomebrowser(genome::String, datasets...)

Construct a genome browser for a `genome` and some `datasets`.

The `genome` must be a named genome that is supported.
Currently supported genomes include:

GRCh38
"""
function genomebrowser(genome, inline = false, datasets...)
    if !haskey(supported_genomes, genome)
        error("Genome $(genome) is not currently supported.")
    end

    sources = Dict[]
    
    for dataset in datasets
       # Generate a random ID for the dataset.
       id = string(Base.Random.uuid4())
       # Prepare dataset by writing it to a suitable file format - but in
       # memory in DATASETS[id], not to file.
       if inline
           inlined_data = JSONText("new Blob([new Uint8Array($(JSON.json(prepare_dataset(dataset))))])")
           push!(sources, Dict(
               "name" => "User Data",
               "bwgBlob" => inlined_data
           ))
        else
            DATASETS[id] = prepare_dataset(dataset)
            # Push prepared dataset to the sources store for the genome browser.
            # TODO: some way to set "names".
            push!(sources, Dict(
             "name"   => "User Data",
             "bwgURI" => "http://localhost:$(HTTP_SERVER_PORT)/$(id)"))
        end
    end

    # TODO: Add any genome at all, not just "supported" ones.
    push!(sources,
        Dict("name"     => "Genome",
             "twoBitURI" => supported_genomes[genome]["sequence"],
             "tier_type" => "sequence"))

    return GenomeBrowser(supported_genomes[genome], sources)
end

function write_html(io::IO, browser::GenomeBrowser)
    start_server()
    divid = string(Base.Random.uuid4())
    config = Dict(
        "pageName" => divid,
        "chr"       => browser.genome_config["chr"],
        "viewStart" => browser.genome_config["viewStart"],
        "viewEnd"   => browser.genome_config["viewEnd"],
        "coordSystem" => Dict(
            "speciesName" => browser.genome_config["speciesName"],
            "taxon"       => browser.genome_config["taxon"],
            "auth"        => browser.genome_config["auth"],
            "version"     => browser.genome_config["version"],
            "ucscName"    => browser.genome_config["ucscName"]
        ),
        "sources" => browser.sources)

    println(io, "<script language=\"javascript\">\n", read(dalliancejs, String), "</script>")
    println(io,
        """
            <script language="javascript">
                new window.Browser(
        """)

    println(io, json(config))
    println(io,
        """
                );
            </script>
        """)
    println(io, "<div id=\"", divid, "\"/>")
end
    

function show(io::IO, ::MIME"text/html", browser::GenomeBrowser)
    write_html(io, browser)
end

end # module GenomeBrowsers
