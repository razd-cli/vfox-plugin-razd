local util = require("util")

--- Return all available versions provided by this plugin
--- @param ctx table Empty table used as context, for future extension
--- @return table Descriptions of available versions and accompanying tool descriptions
function PLUGIN:Available(ctx)
    -- Fetch releases from GitHub API
    local releases, err = util.fetch_github_releases()
    
    if err ~= nil then
        -- Return empty array on error, vfox will handle the message
        print("Error fetching razd releases: " .. err)
        return {}
    end
    
    -- Parse and format releases
    local versions = util.parse_releases(releases)
    
    return versions
end