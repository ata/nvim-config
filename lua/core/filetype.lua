vim.filetype.add({
    extension = {
        -- foo = 'fooscript'
    },
    filename = {
        -- ['.foorc'] = 'toml',
    },
    pattern = {
        ['docker-.*.ya?ml'] = 'yaml.docker-compose',
        ['templates/.*.yaml'] = 'helm'
    },
})
