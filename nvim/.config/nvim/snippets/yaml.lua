local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("checkout", {
        t("- uses: actions/checkout@v"),
        i(1, "6"),
    }),
}
