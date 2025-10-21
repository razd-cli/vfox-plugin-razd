local http = require("http")
local json = require("json")

local util = {}

--- Fetch releases from GitHub API
--- @return table|nil releases array or nil on error
--- @return string|nil error message if failed
function util.fetch_github_releases()
    local url = "https://api.github.com/repos/tursodatabase/turso/releases"
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

--- Get platform-specific asset name for TursoDB
--- @param version string Version number (without 'v' prefix) - not used as assets don't include version
--- @param os_type string Operating system type
--- @param arch_type string Architecture type
--- @return string|nil Asset filename or nil if unsupported
function util.get_asset_name(version, os_type, arch_type)
    -- Note: TursoDB release assets do NOT include version in filename
    local platform_map = {
        windows = {
            ["x86_64"] = "turso_cli-x86_64-pc-windows-msvc.zip",
            ["amd64"] = "turso_cli-x86_64-pc-windows-msvc.zip",
        },
        darwin = {
            ["x86_64"] = "turso_cli-x86_64-apple-darwin.tar.xz",
            ["amd64"] = "turso_cli-x86_64-apple-darwin.tar.xz",
            ["arm64"] = "turso_cli-aarch64-apple-darwin.tar.xz",
            ["aarch64"] = "turso_cli-aarch64-apple-darwin.tar.xz",
        },
        linux = {
            ["x86_64"] = "turso_cli-x86_64-unknown-linux-gnu.tar.xz",
            ["amd64"] = "turso_cli-x86_64-unknown-linux-gnu.tar.xz",
            ["arm64"] = "turso_cli-aarch64-unknown-linux-gnu.tar.xz",
            ["aarch64"] = "turso_cli-aarch64-unknown-linux-gnu.tar.xz",
        }
    }
    
    if platform_map[os_type] and platform_map[os_type][arch_type] then
        return platform_map[os_type][arch_type]
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
    
    return "https://github.com/tursodatabase/turso/releases/download/v" .. version .. "/" .. asset_name
end

return util