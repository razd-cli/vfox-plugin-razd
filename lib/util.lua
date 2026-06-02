local http = require("http")
local json = require("json")

local util = {}

--- Fetch releases from GitHub API
--- @return table|nil releases array or nil on error
--- @return string|nil error message if failed
function util.fetch_github_releases()
    local url = "https://api.github.com/repos/razd-cli/razd/releases"
    local resp, err = http.get({
        url = url,
        headers = {
            ["Accept"] = "application/vnd.github.v3+json"
        }
    })
    
    if err ~= nil or resp.status_code ~= 200 then
        return nil, "Failed to fetch releases from GitHub: " .. (err or "HTTP " .. resp.status_code)
    end
    
    local releases, decode_err = json.decode(resp.body)
    if decode_err ~= nil then
        return nil, "Failed to parse GitHub response: " .. decode_err
    end
    
    return releases, nil
end

--- Parse releases and extract version information
--- @param releases table Array of release objects from GitHub API
--- @return table Array of formatted version entries
function util.parse_releases(releases)
    local versions = {}
    
    for _, release in ipairs(releases) do
        -- Skip drafts and pre-releases initially (can be configurable later)
        if not release.draft then
            local version = release.tag_name
            -- Remove 'v' prefix if present (e.g., v0.2.2 -> 0.2.2)
            if version:sub(1, 1) == "v" then
                version = version:sub(2)
            end
            
            local note = ""
            if release.prerelease then
                note = "Pre-release"
            elseif release.tag_name == releases[1].tag_name then
                note = "Latest"
            end
            
            table.insert(versions, {
                version = version,
                note = note
            })
        end
    end
    
    return versions
end

--- Get platform-specific asset name for razd
--- @param version string Version number (without 'v' prefix)
--- @param os_type string Operating system type
--- @param arch_type string Architecture type
--- @return string|nil Asset filename or nil if unsupported
function util.get_asset_name(version, os_type, arch_type)
    local ext = "tar.gz"
    if os_type == "windows" then
        ext = "zip"
    end

    local arch = arch_type
    if arch_type == "x86_64" then
        arch = "amd64"
    elseif arch_type == "aarch64" then
        arch = "arm64"
    end

    local os_name = os_type
    if os_type == "darwin" then
        os_name = "darwin"
    end

    local asset = "razd_" .. os_name .. "_" .. arch .. "." .. ext

    if (os_type == "linux" or os_type == "darwin" or os_type == "windows")
        and (arch == "amd64" or arch == "arm64") then
        return asset
    end

    return nil
end
    
    return nil
end

--- Get download URL for specific version and platform
--- @param version string Version number (without 'v' prefix)
--- @param os_type string Operating system type
--- @param arch_type string Architecture type
--- @return string|nil Download URL or nil if unsupported
function util.get_download_url(version, os_type, arch_type)
    local asset_name = util.get_asset_name(version, os_type, arch_type)
    if not asset_name then
        return nil
    end
    
    return "https://github.com/razd-cli/razd/releases/download/v" .. version .. "/" .. asset_name
end

return util