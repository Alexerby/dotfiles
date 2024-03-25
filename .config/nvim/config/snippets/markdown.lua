local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("t-konto-multi", {
        t({
            "<div class='t-konto-multi'>",
            "    <table class='t-konto'>",
            "        <tr>",
            "            <th colspan='2'>",
        }),
        i(1, "konto"),
        t({
            "</th>",
            "        </tr>",
            "        <tr>",
            "            <td></td>",
            "            <td></td>",
            "        </tr>",
            "        <tr>",
            "            <td></td>",
            "            <td></td>",
            "        </tr>",
            "    </table>",
            "</div>"
        })
    })
}
