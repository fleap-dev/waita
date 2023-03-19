local util = require("waita.util")
local colors = require("waita.colors")

local M = {}

function M.setup()
	local p = colors.palette
	local hls = M.get_highlights(p)

	vim.cmd("highlight clear")
	if vim.g.syntax_on then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "waita"
	vim.o.background = "dark"

	for group, hl in pairs(hls) do
		util.highlight(group, hl)
	end
end

function M.get_highlights(p)
	-- Common values
	local def = {
		bg = p.background1, -- Background
		fg = p.light2, -- Foreground
		bg_float = p.background1, -- Background in floating windows
		border = p.background2, -- Border color
		border_fg = p.ligh5, -- Border chars
		comment = p.dark2, -- Comments (in code)
		error = p.red2, -- Error messages
		warning = p.orange2, -- Warning messages
		info = p.green1,
		hint = p.blue1,
		gutter = p.light5, -- Gutter text color
	}
	return {
		Comment = { fg = def.comment, italic = true }, -- any comment
		ColorColumn = { bg = p.dark1 }, -- used for the columns set with 'colorcolumn'
		Conceal = { fg = p.dark5 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
		Cursor = { fg = def.bg, bg = def.fg }, -- character under the cursor
		lCursor = { fg = def.bg, bg = def.fg }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
		CursorIM = { fg = def.bg, bg = def.fg }, -- like Cursor, but used when in IME mode |CursorIM|
		CursorColumn = { bg = p.background2 }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorLine = { bg = p.background2 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
		Directory = { fg = p.blue3 }, -- directory names (and other special names in listings)
		DiffAdd = { bg = p.green4 }, -- diff mode: Added line |diff.txt|
		DiffChange = { bg = p.yellow4 }, -- diff mode: Changed line |diff.txt|
		DiffDelete = { bg = p.red2 }, -- diff mode: Deleted line |diff.txt|
		DiffText = { bg = p.yellow4 }, -- diff mode: Changed text within a changed line |diff.txt|
		EndOfBuffer = { fg = def.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
		-- TermCursor  = { }, -- cursor in a focused terminal
		-- TermCursorNC= { }, -- cursor in an unfocused terminal
		ErrorMsg = { fg = def.error }, -- error messages on the command line
		VertSplit = { fg = def.border }, -- the column separating vertically split windows
		WinSeparator = { fg = def.border, bold = true }, -- the column separating vertically split windows
		Folded = { fg = p.blue1 }, -- line used for closed folds
		FoldColumn = { bg = def.bg, fg = def.comment }, -- 'foldcolumn'
		SignColumn = { bg = def.bg, fg = def.border }, -- column where |signs| are displayed
		SignColumnSB = { bg = def.border, fg = def.gutter }, -- column where |signs| are displayed
		Substitute = { bg = p.green1, fg = p.dark5 }, -- |:substitute| replacement text highlighting
		LineNr = { fg = def.gutter }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		CursorLineNr = { fg = def.fg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		MatchParen = { bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg = { fg = def.bg, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
		MsgArea = { fg = p.text_light1 }, -- Area for messages and cmdline
		-- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
		MoreMsg = { fg = p.green5 }, -- |more-prompt|
		NonText = { fg = p.text_dark3 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		Normal = { fg = def.fg, bg = def.bg }, -- normal text
		NormalNC = { fg = def.fg, bg = def.bg }, -- normal text in non-current windows
		NormalSB = { fg = def.fg, bg = def.bg }, -- normal text in sidebar
		NormalFloat = { fg = def.fg, bg = def.bg_float }, -- Normal text in floating windows.
		FloatBorder = { fg = def.border_fg, bg = def.bg_float },
		Pmenu = { bg = p.background2, fg = p.fg }, -- Popup menu: normal item.
		PmenuSel = { bg = util.lighten(p.background2, 0.8), bold = true }, -- Popup menu: selected item.
		PmenuSbar = { bg = util.lighten(p.background2, 0.90) }, -- Popup menu: scrollbar.
		PmenuThumb = { bg = def.gutter }, -- Popup menu: Thumb of the scrollbar.
		Question = { fg = p.blue3 }, -- |hit-enter| prompt and yes/no questions
		QuickFixLine = { bg = p.blue3, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		Search = { bg = p.green4, fg = def.fg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
		IncSearch = { bg = p.green4, fg = def.fg }, -- 'incsearch' highlighting, also used for the text replaced with ":s///c"
		SpecialKey = { fg = p.red3 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
		-- SpellBad = { sp = c.error, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		-- SpellCap = { sp = c.warning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		-- SpellLocal = { sp = c.info, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		-- SpellRare = { sp = c.hint, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
		StatusLine = { fg = def.fg, bg = p.background2 }, -- status line of current window
		StatusLineNC = { fg = def.fg, bg = p.background2 }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		-- TabLine = { bg = c.bg_statusline, fg = c.fg_gutter }, -- tab pages line, not active tab page label
		-- TabLineFill = { bg = c.black }, -- tab pages line, where there are no labels
		-- TabLineSel = { fg = c.black, bg = c.blue }, -- tab pages line, active tab page label
		-- Title = { fg = c.blue, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
		Visual = { bg = p.text_selection }, -- Visual mode selection
		VisualNOS = { bg = p.text_selection }, -- Visual mode selection when vim is "Not Owning the Selection".
		WarningMsg = { fg = def.warning }, -- warning messages
		-- Whitespace = { fg = c.fg_gutter }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		-- WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion
		--
		-- -- These groups are not listed as default vim groups,
		-- -- but they are defacto standard group names for syntax highlighting.
		-- -- commented out groups should chain up to their "preferred" group by
		-- -- default,
		-- -- Uncomment and edit if you want more specific syntax highlighting.
		--
		Constant = { fg = p.orange3 }, -- (preferred) any constant
		String = { fg = p.yellow2 }, --   a string constant: "this is a string"
		Character = { fg = p.yellow2 }, --  a character constant: 'c', '\n'
		-- Number        = { }, --   a number constant: 234, 0xff
		-- Boolean       = { }, --  a boolean constant: TRUE, false
		-- Float         = { }, --    a floating point constant: 2.3e10

		Identifier = { fg = p.text_light2 }, -- (preferred) any variable name
		Function = { fg = p.green1 }, -- function name (also: methods for classes)
		-- TODO
		Statement = { fg = p.red1 }, -- (preferred) any statement
		-- Conditional   = { }, --  if, then, else, endif, switch, etc.
		-- Repeat        = { }, --   for, do, while, etc.
		-- Label         = { }, --    case, default, etc.
		Operator = { fg = p.red1 }, -- "sizeof", "+", "*", etc.
		Keyword = { fg = p.red1, bold = true }, --  any other keyword
		-- Exception     = { }, --  try, catch, throw

		PreProc = { fg = p.blue2 }, -- (preferred) generic Preprocessor
		-- Include       = { }, --  preprocessor #include
		-- Define        = { }, --   preprocessor #define
		Macro = { fg = p.blue2, bold = true }, --    same as Define
		-- PreCondit     = { }, --  preprocessor #if, #else, #endif, etc.

		Type = { fg = p.green3, bold = true }, -- (preferred) int, long, char, etc.
		-- StorageClass  = { }, -- static, register, volatile, etc.
		-- Structure     = { }, --  struct, union, enum, etc.
		-- Typedef       = { }, --  A typedef

		-- TODO
		Special = { fg = p.red1 }, -- (preferred) any special symbol
		-- SpecialChar   = { }, --  special character in a constant
		-- Tag           = { }, --    you can use CTRL-] on this
		-- Delimiter     = { }, --  character that needs attention
		-- SpecialComment= { }, -- special things inside a comment
		-- Debug         = { }, --    debugging statements

		Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
		Bold = { bold = true },
		Italic = { italic = true },

		Error = { fg = def.error }, -- (preferred) any erroneous construct
		Todo = { bg = p.yellow3, fg = def.bg }, -- (preferred) anything that needs extra attention, mostly the keywords TODO FIXME and XXX
		DiagnosticError = { fg = def.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
		DiagnosticWarn = { fg = def.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
		DiagnosticInfo = { fg = def.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
		DiagnosticHint = { fg = def.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
		--
		DiagnosticVirtualTextError = { fg = def.error, italic = true }, -- Used for "Error" diagnostic virtual text
		DiagnosticVirtualTextWarn = { fg = def.warning, italic = true }, -- Used for "Warning" diagnostic virtual text
		DiagnosticVirtualTextInfo = { fg = def.info, italic = true }, -- Used for "Information" diagnostic virtual text
		DiagnosticVirtualTextHint = { fg = def.hint, italic = true }, -- Used for "Hint" diagnostic virtual text
		--
		DiagnosticUnderlineError = { undercurl = true, sp = def.error }, -- Used to underline "Error" diagnostics
		DiagnosticUnderlineWarn = { undercurl = true, sp = def.warning }, -- Used to underline "Warning" diagnostics
		DiagnosticUnderlineInfo = { undercurl = true, sp = def.info }, -- Used to underline "Information" diagnostics
		DiagnosticUnderlineHint = { undercurl = true, sp = def.hint }, -- Used to underline "Hint" diagnostics
		--
		LspSignatureActiveParameter = { fg = p.orange2 },
		LspCodeLens = { fg = def.comment },
    --
    -- TreeSitter highlights
    --
		["@type.qualifier"] = { fg = p.red1, bold = true },
		["@include"] = { fg = p.red1, bold = true },
		["@parameter"] = { fg = p.orange3, italic = true },
		["@label"] = { fg = p.orange2, italic = true },
		["@variable"] = { fg = p.text_light2 },
		["@keyword"] = { fg = p.red1, bold = true },
		["@repeat"] = { fg = p.red1, bold = true },
		["@boolean"] = { fg = p.red1, bold = true },
		["@variable.builtin"] = { fg = p.red1 },
    ["@constant"] = { fg = p.orange1, bold = false }, -- For constants
    ["@text.title"] = { fg = p.text_light2, bold = true }, -- For constants
    ["@storageclass.lifetime"] = { fg = p.green4, italic = true }, -- For constants
		TSAnnotation = { fg = p.blue2 }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
		TSAttribute = { fg = p.blue2 }, -- (unstable) TODO: docs
		TSBoolean = { fg = p.red1 }, -- For booleans.
		-- TSCharacter         = { },    -- For characters.
		-- TSComment           = { },    -- For comment blocks.
		TSNote = { fg = def.info },
		TSWarning = { fg = def.warning },
		TSDanger = { fg = def.error },
		TSConstructor = { fg = p.red1 }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
		TSConditional = { fg = p.red1 }, -- For keywords related to conditionnals.
		TSConstBuiltin = { fg = p.green2 }, -- For constant that are built in the language: `nil` in Lua.
		-- TSConstMacro        = { fg = p.red1 },    -- For constants that are defined by macros: `NULL` in C.
		TSError = { fg = def.error }, -- For syntax/parser errors.
		-- TSException         = { },    -- For exception related keywords.
		TSField = { fg = p.text_light2 }, -- For fields.
		-- TSFloat             = { },    -- For floats.
		TSFunction = { fg = p.green1 }, -- For function (calls and definitions).
		TSFuncBuiltin = { fg = p.green1 }, -- For builtin functions: `table.insert` in Lua.
		TSFuncMacro = { fg = p.blue2, bold = true }, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
		TSInclude = { fg = p.red1, bold = true }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
		TSKeyword = { fg = p.red1, bold = true }, -- For keywords that don't fall in previous categories.
		TSKeywordFunction = { fg = p.red1, bold = true }, -- For keywords used to define a fuction.
		TSLabel = { fg = p.blue3 }, -- For labels: `label:` in C and `:label:` in Lua.
		TSMethod = { fg = p.green1 }, -- For method calls and definitions.
		TSNamespace = { fg = p.text_light2 }, -- For identifiers referring to modules and namespaces.
		-- TSNone              = { fg = p.red1 },    -- TODO: docs
		TSNumber = { fg = p.purple1 }, -- For all numbers
		TSOperator = { fg = p.red1, bold = true }, -- For any operator: `+`, but also `->` and `*` in C.
		TSParameter = { fg = p.orange1 }, -- For parameters of a function.
		TSParameterReference = { fg = p.orange1 }, -- For references to parameters of a function.
		TSProperty = { fg = p.blue1 }, -- Same as `TSField`.
		TSPunctDelimiter = { fg = p.text_light5 }, -- For delimiters ie: `.`
		TSPunctBracket = { fg = p.text_light5 }, -- For brackets and parens.
		TSPunctSpecial = { fg = p.text_light5 }, -- For special punctutation that does not fall in the catagories before.
		TSRepeat = { fg = p.red1 }, -- For keywords related to loops.
		TSString = { fg = p.yellow2 }, -- For strings.
		TSStringRegex = { fg = p.orange2 }, -- For regexes.
		TSStringEscape = { fg = p.purple1 }, -- For escape characters within a string.
		TSSymbol = { fg = p.green3, bold = true }, -- For identifiers referring to symbols or atoms.
		TSType = { fg = p.green3, bold = true }, -- For types.
		TSTypeBuiltin = { fg = p.green3, bold = true }, -- For builtin types.
		TSVariable = { fg = p.text_light2 }, -- Any variable name that does not have another highlight.
		TSVariableBuiltin = { fg = p.red1 }, -- Variable names that are defined by the languages, like `this` or `self`.
		-- TSTag               = { },    -- Tags like html tag names.
		-- TSTagDelimiter      = { },    -- Tag delimiter like `<` `>` `/`
		TSText = { fg = p.text_light2 }, -- For strings considered text in a markup language.
		TSTextReference = { fg = p.text_light3 },
		TSEmphasis = { bold = true }, -- For text to be represented with emphasis.
		TSUnderline = { underline = true }, -- For text to be represented with an underline.
		TSStrike = { strikethrough = true }, -- For strikethrough text.
		TSTitle = { bold = true }, -- Text that is part of a title.
		-- TSLiteral           = { },    -- Literal text.
		TSURI = { fg = p.blue1 }, -- Any URI like a link or email.
		-- Telescope
		TelescopeBorder = { fg = def.border_fg, bg = def.bg },
		TelescopeNormal = { fg = def.fg, bg = def.bg },
		-- NvimTree
		NvimTreeNormal = { fg = def.fg, bg = def.bg },
		NvimTreeFolderName = { fg = p.blue1 },
		NvimTreeRootFolder = { fg = p.blue2, bold = true },
		NvimTreeGitDirty = { italic = true },
		NvimTreeGitNew = { italic = true },
		NvimTreeGitDeleted = { strikethrough = true },
		NvimTreeOpenedFile = { bg = util.lighten(def.bg, 0.3) },
		NvimTreeSpecialFile = { fg = p.green2 },
		NvimTreeSymlink = { fg = p.yellow3 },
	}
end

return M
