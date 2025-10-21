local util = require("util")

--- Returns some pre-installed information, such as version number, download address, local files, etc.
--- If checksum is provided, vfox will automatically check it for you.
--- @param ctx table
--- @field ctx.version string User-input version
--- @return table Version information
function PLUGIN:PreInstall(ctx)
    local version = ctx.version
    local os_type = RUNTIME.osType
    local arch_type = RUNTIME.archType
    
    -- Get download URL for the platform
    local url = util.get_download_url(version, os_type, arch_type)
    
    if not url then
        -- Unsupported platform/architecture combination
        return {
            version = "",
            note = "Unsupported platform: " .. os_type .. "/" .. arch_type .. 
                   ". TursoDB supports Windows (x64), macOS (x64/arm64), and Linux (x64/arm64)."
        }
    end
    
    return {
        version = version,
        url = url,
        note = "Installing TursoDB CLI " .. version .. " for " .. os_type .. "/" .. arch_type
    }
end