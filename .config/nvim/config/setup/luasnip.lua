local ls = require("luasnip")

local node = ls.snippet_node
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local extras = require("luasnip.extras")
local r = extras.rep

local newline = t({ "", " " })


ls.add_snippets("markdown", {
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
)


ls.add_snippets("tex", {
    s("equation", {
        t("\\begin{equation}"),
        i(1, ""),
        t("\\end{equation}")
    }),

	s("bmath", {
		t("\\[ "),
		i(1, ""),
		t(" \\]")
	}),

	s("imath", {
		t("\\( "),
		i(1, ""),
		t(" \\)")
	}),

	s("frac", {
		t("\\frac{"),
		i(1, ""),
		t("}"),
		t("{"),
		i(2, ""),
		t("}")
	}),


    s("section", {
        t("\\section{"),
        i(1, "Section Title"),
        t("}")
    }),

    s("subsection", {
        t("\\subsection{"),
        i(1, "Section Title"),
        t("}")
    }),

    s("subsubsection", {
        t("\\subsubsection{"),
        i(1, "Section Title"),
        t("}")
    }),


	s("template_notes", {
			-- Choose document class
			t("\\documentclass{"), i(1, "documentclass"), t("}"),
			newline,
			newline,

			-- Import packages
			t("\\input{/home/aleri/Dropbox/latex/templates/notes/packages}"),
			newline,
			t("\\input{/home/aleri/Dropbox/latex/templates/notes/environments}"),


			-- Choose title, date & author
			newline,
			newline,
			t("\\title{"), i(2, "title"), t("}"),
			newline,
			t("\\date{"), i(3, ""), t("}"),
			newline,
			t("\\author{"), i(4, "Alexander Eriksson Byström"), t("}"),

			-- Create doc env
			newline,
			newline,
			t("\\begin{document}"),
			newline,
			newline,
			t("\\maketitle"),
			newline,
			newline,
			t({ "", " " }), i(5),
			newline,
			newline,
			t("\\end{document}"),

    }),

	s("it", {
		t("\\textit{"),
		i(1, ""),
		t("} "),
	}),

	s("bf", {
		t("\\textbf{"),
		i(1, ""),
		t("}"),
	}),

	s("cite", {
		t("``"), i(1, ""), t("``"),
	}),

	s("env", {
		t("\\begin{"), i(1), t("}"),
		t({ "", "\t"}), i(0),
		t({ "", "\\end{" }), r(1), t("}"),
	})
})


