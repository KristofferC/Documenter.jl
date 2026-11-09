module DocumenterGhosttyVTExt

import Documenter
import GhosttyVT

# Wide enough that captured lines never wrap, so `\r` redraws of long lines
# behave as they would in a terminal that fits them.
const COLUMNS = 1000
const ROWS = 100

function render_terminal_output(s::AbstractString)
    t = GhosttyVT.Terminal(COLUMNS, ROWS; linefeed = true)
    try
        write(t, s)
        out = GhosttyVT.format(t, :vt; unwrap = true, extras = false)
        return replace(out, "\r\n" => "\n")
    finally
        close(t)
    end
end

function __init__()
    Documenter.TERMINAL_OUTPUT_RENDERER[] = render_terminal_output
    return
end

end
