
# Associate unique identifiers with datasets being served through http to dalliance.
const DATASETS = Dict{String, Vector{UInt8}}()

const HTTP_SERVER_PORT = 8001
# HTTP Server instance.
let HTTP_SERVER = Nullable{Server}()
    global start_server
    function start_server()
        if isnull(HTTP_SERVER)
            HTTP_SERVER = Nullable{Server}(Server(http_handler))
            @async run(get(HTTP_SERVER), host = IPv4(127, 0, 0, 1), port = HTTP_SERVER_PORT)
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
    first = parse(Int, m.captures[1]) + 1
    last  = parse(Int, m.captures[2]) + 1
    range = first:min(last, length(data))

    return Response(data[range], h)
end
