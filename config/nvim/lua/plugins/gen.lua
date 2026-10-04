return {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "translategemma:12b",
      host = "localhost",
      port = "11434",
      body = { stream = true, keep_alive = 0 },
      init = function()
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
        vim.fn.system({ "ollama", "stop", "gpt-oss:20b" })
      end,
    },
    config = function(_, opts)
      local gen = require("gen")
      gen.setup(opts)
      gen.prompts["Translate to German"] = {
        prompt = "You are a professional translator. Detect the source language and translate the following text into German. Produce only the German translation, without any additional explanations or commentary.\n\n$text",
        replace = true,
      }
      gen.prompts["Translate to English"] = {
        prompt = "You are a professional translator. Detect the source language and translate the following text into English. Produce only the English translation, without any additional explanations or commentary.\n\n$text",
        replace = true,
      }
    end,
  },
}
