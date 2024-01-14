return {
    "nathom/filetype.nvim",
    opts = {
        overrides = {
            complex = {
                ["docker-compose.*"] = "yaml.docker-compose",
                ["Dockerfile*"] = "dockerfile",
            },
        }
    }
}
