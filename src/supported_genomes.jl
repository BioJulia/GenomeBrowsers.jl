const supported_genomes = Dict(
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
