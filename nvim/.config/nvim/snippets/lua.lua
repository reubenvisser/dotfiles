local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
    s("req", { t("local "), i(1, "mod"), t(" = require('"), rep(1), t("')") }),
    s("fn", { t("function "), i(1, "name"), t("()"), t({"", "\t"}), i(0), t({"", "end"}) }),
}
