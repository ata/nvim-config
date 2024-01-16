return {
    "nathom/filetype.nvim",
    opts = {
        overrides = {
            complex = {
                ["docker-.*.yaml"] = "yaml.docker-compose",
                ["docker-.*.yml"] = "yaml.docker-compose",
                ["Dockerfile.*"] = "dockerfile",
                ["templates/.*.yaml"] = "helm",
            },
        }
    }
}
