--- Each SDK may have different environment variable configurations.
--- This allows plugins to define custom environment variables (including PATH settings)
--- Note: Be sure to distinguish between environment variable settings for different platforms!
--- @param ctx table Context information
--- @field ctx.path string SDK installation directory
function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path
    
    -- razd binary is typically extracted directly to the SDK root
    -- The archive structure places the razd binary in the root directory
    return {
        {
            key = "PATH",
            value = mainPath
        }
    }
end