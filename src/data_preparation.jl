
#= TODO: Define these using the new IO API.
function prepare_dataset(dataset::IntervalCollection{BEDMetadata})
    out = IOBuffer()
    write(out, BigBed, dataset)
    return takebuf_array(out)
end

function prepare_dataset(dataset::IntervalStream{BEDMetadata})
    ic = IntervalCollection{BEDMetadata}()
    for interval in dataset
        push!(ic, interval)
    end
    return prepare_dataset(ic)
end
=#

function prepare_dataset(dataset::IntervalCollection{T}) where {T <: Number}
    clens = Dict{String, Int64}()
    infer_chromlens!(clens, dataset)
    buffer = IOBuffer()
    writer = BigWig.Writer(buffer, clens)
    for interval in dataset
        write(writer, interval)
    end
    close(writer)
    return take!(IOBuffer(buffer.data))
end

# A generic catchall
function prepare_dataset(dataset)
    error("GenomeBrowsers does not currently support data of type $(typeof(dataset))")
end

# TODO: Stop using dot notation to access internal fields of IntervalCollection.
function infer_chromlens!(chrom_sizes::Dict{String, Int64}, intervals::IntervalCollection)
    for seqname in keys(intervals.trees)
        if !haskey(chrom_sizes, seqname)
            chrom_sizes[seqname] = length(intervals.trees[seqname]) > 0 ? intervals.trees[seqname].root.maxend : 0
        end
    end
end