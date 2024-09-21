--[[
-- Reformat all heading text 
function Div (div)
  if div.classes:includes 'notes' then
    return {}
  end
end
]]

--[[
if FORMAT ~= "pdf" then
  print("This filter only works with Beamer. Sorry.")
  return
end
]]

--p stands for parameters
local p = {
  ["displayNotes"] = false,
  ["notesTitle"] = "Notes",
  ["borderColor"] = "red",
  ["backgroundColor"] = "white",
  }

-- For PDF output
local neededPackages = [[
\makeatletter
\@ifpackageloaded{tikz}{}{\usepackage{mdframed}}
\makeatother
]]

local function makeNotesEnv(title, border, background)
  local notesEnv = ""
  if quarto.doc.is_format("pdf") then
    local newmdenv = [[\newmdenv[linecolor=]] .. border .. [[,backgroundcolor=]] .. background .. [[,frametitle=]] .. title .. [[]{notes}]]
    notesEnv = newmdenv
  end
  return notesEnv
end

local function parameters(meta)
  --Retrieve parameters from the YAML header
  if meta.speakernotes ~= nil then
    for k, v in pairs(meta.speakernotes) do p[k] = pandoc.utils.stringify(v) end
  end
  if p.displayNotes == "true" then
    --Retrieve header-includes content and append our content
    local includes = meta['header-includes']
    --Default to a list
    includes = includes or pandoc.List({ })
    -- If not a List make it one!
    if 'List' ~= pandoc.utils.type(includes) then
      includes = pandoc.List({ includes })
    end
    includes:insert(pandoc.RawBlock('latex', neededPackages))
    notesEnv = makeNotesEnv(p.notesTitle, p.borderColor, p.backgroundColor)
    includes:insert(pandoc.RawBlock('latex', notesEnv))
    -- Make sure Pandoc gets our changes
    meta['header-includes'] = includes
    --End of code from fonts-and-alignment.lua
  end
  return meta
end

function notesDiv(el)
  if el.classes[1] == "notes" then
    if p.displayNotes == "true" then
      -- insert element in front
      table.insert(
        el.content, 1,
        pandoc.RawBlock("latex", "\\begin{notes}"))
      -- insert element at the back
      table.insert(
        el.content,
        pandoc.RawBlock("latex", "\\end{notes}"))
    else
      el = {}
    end
  end
  return el
end

return {{Meta = parameters}, {Div = notesDiv}}
