local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("req", { t("local "), i(1, "mod"), t(" = require('"), i(2, "module"), t("')") }),
    s("fn", { t("function "), i(1, "name"), t("()"), t({"", "\t"}), i(0), t({"", "end"}) }),
}
