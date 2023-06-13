local M = {}

if vim.fn.has('linux') == 0 then -- gate iggå always
    print("snd not supported on this platform")
end

local function create_job()
    local jobCommand
    local p= vim.fn.expand("%:p");
    -- print("snd.nvim: run → " ..p)
    jobCommand = 'snd ' ..p
    jobId= vim.fn.jobstart(jobCommand, {
        detach= true,
        on_exit= function ()
            M.jobId= nil
        end,
        -- rpc= true
    })
end

M.run = function()
    if jobId then
        vim.fn.jobstop(jobId)
        vim.fn.jobwait({jobId})
        create_job()
        -- _a.chansend(M.jobId, '-l ' ..p)
        -- if _a.jobpid(M.jobId) then
        -- print(_a.jobpid(M.jobId))
    else
        create_job()
    end

end

vim.api.nvim_create_user_command("SndRun", M.run, {})

vim.g.snd_keymaps = vim.g.snd_keymaps or {exec='<C-e>'}
vim.g.snd_filetypes = vim.g.snd_filetypes or {"*.scm"--[[ , "*.forth", "*.fth", "*.4th", "*.frt", "*.rb" ]]}
vim.g.snd_dev = vim.g.snd_dev or false

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = vim.g.snd_filetypes,
    callback = function(ev)
        -- print(string.format('event fired: s', vim.inspect(ev)))
        vim.keymap.set('n', vim.g.snd_keymaps['exec'], ':SndRun<cr>', { silent = true })
    end
})

--------------------------------------------------
--                 dev reloader                 --
--------------------------------------------------
if vim.g.snd_dev then
    vim.api.nvim_create_user_command("SndDevUpdate", function()
        if vim.fn.expand("%:p:h:h:t") == "snd.nvim" then
            package.loaded.snd = nil
            require("snd")
        else
            print("working dir is: ".. vim.fn.getcwd())
        end
    end, {})
end

return M
