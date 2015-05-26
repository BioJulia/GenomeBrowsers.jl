
module Dalliance

export genomebrowser

const dalliancejs = Pkg.dir("Dalliance", "data", "dalliance-compiled.js")

import Base: writemime

using Compat, HttpServer, JSON, Bio, Bio.Intervals
import HttpCommon

const HTTP_SERVER_PORT = 8001

immutable DallianceBrowser
    genome_config::Dict
    sources::Vector{Dict}
end

function genomebrowser(genome::String, datasets...)
    if !haskey(supported_genomes, genome)
        error("Genome $(genome) is not currently supported.")
    end

    sources = Dict[]
    for dataset in datasets
        id = string(Base.Random.uuid4())
        if isa(dataset, IntervalCollection)
            out = IOBuffer()
            write(out, BigBed, dataset)
            DATASETS[id] = takebuf_array(out)
        elseif isa(dataset, Intervals.BEDIterator)
            ic = IntervalCollection{BEDMetadata}()
            for interval in dataset
                push!(ic, interval)
            end
            out = IOBuffer()
            write(out, BigBed, ic)
            DATASETS[id] = takebuf_array(out)
        else
            error("Dalliance does not currently support data of type $(typeof(dataset))")
        end
        push!(sources, @compat Dict(
            "name"   => "User Data", # TODO: some way to set names
            "bwgURI" => "http://localhost:$(HTTP_SERVER_PORT)/$(id)"))
    end

    push!(sources,
        @compat Dict("name"      => "Genome",
                     "twoBitURI" => supported_genomes[genome]["sequence"],
                     "tier_type" => "sequence"))
    
    return DallianceBrowser(supported_genomes[genome], sources)
end


const supported_genomes = @compat Dict(
    "GRCh38" => Dict(
        "speciesName" => "Human",
        "taxon"       => 9606,
        "auth"        => "GRCh",
        "version"     => "38",
        "ucscName"    => "hg38",
        "chr"         => "1",
        "viewStart"   => 1,
        "viewEnd"     => 100000,
        "sequence"    => "http://www.biodalliance.org/datasets/hg38.2bit"
    ),

    "GRCh37" => Dict(
        "speciesName" => "Human",
        "taxon"       => 9606,
        "auth"        => "GRCh",
        "version"     => "37",
        "ucscName"    => "hg19",
        "chr"         => "1",
        "viewStart"   => 1,
        "viewEnd"     => 100000,
        "sequence"    => "http://www.biodalliance.org/datasets/hg19.2bit"
    )

    # TODO: More genomes.
)

# Associate unique identifiers with datasets being served through http to dalliance.
const DATASETS = Dict{String, Vector{Uint8}}()

# HTTP Server instance.
let HTTP_SERVER = @compat Nullable{Server}()
    global start_server
    function start_server()
        if isnull(HTTP_SERVER)
            HTTP_SERVER = Nullable{Server}(Server(http_handler))
            @async run(get(HTTP_SERVER), host=IPv4(127,0,0,1), port=8001)
            #run(get(HTTP_SERVER), host=IPv4(127,0,0,1), port=8001)
            # TODO: if dalliance tries to access a track before the server is
            # ready, things break. Presumably there is a better solution than
            # this. Or does it...?
            sleep(5)
        end
    end
end

function http_handler(req::Request, res::Response)
    # debug nonsense:
    #logfile = open("/Users/dcjones/dialliance-log.txt", "a")
    #println(logfile, req)
    #close(logfile)

    h = HttpCommon.headers()
    h["Access-Control-Allow-Origin"] = "*"
    h["Access-Control-Allow-Headers"] = "Range"
    h["Access-Control-Max-Age"] = "36000"

    if req.method == "OPTIONS"
        return Response(200, h)
    elseif req.method != "GET" || !haskey(req.headers, "Range")
        return Response(501, h)
    end

    resource = match(r"^/([^?]*)", req.resource).captures[1]
    if !haskey(DATASETS, resource)
        return Response(404, h)
    end
    data = DATASETS[resource]

    m = match(r"bytes=(\d+)-(\d+)", req.headers["Range"])
    range = (parse(Int, m.captures[1]) + 1):(parse(Int, m.captures[2]) + 1)

    return Response(data[range], h)
end


function writemime(io::IO, ::MIME"text/html", browser::DallianceBrowser)
    start_server()

    divid = string(Base.Random.uuid4())

    config = @compat Dict(
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

    println(io, "<script language=\"javascript\" xlink:href=\"", dalliancejs, "\"></script>")
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

end

