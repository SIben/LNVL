--[[
--
-- This file implements characters in LNVL.  Characters represent
-- actors in scenes and are typically the medium through which most
-- dialog will be shown.
--
-- The current line of dialog a character will speak is accessible
-- through the 'currentDialog' property.
--
--]]

-- Create the LNVL.Character class.
LNVL.Character = {}

-- We use a special __index() function for Character objects to create
-- the 'currentDialog' property.  This way we can avoid writing
--
--     character.dialog[character.dialogIndex]
--
-- all throughout the code.
LNVL.Character.__index =
    function (table, key)
        if key == "currentDialog" then
            return table.dialog[table.dialogIndex]
        else
            return rawget(LNVL.Character, key)
        end
    end

-- The constructor for characters.
function LNVL.Character:new(properties)
    local character = {}
    setmetatable(character, LNVL.Character)

     -- name: The name of the character as a string.  Right now we set
     -- it as an empty string because the loop later through
     -- 'properties' should give it a value.  If it does not then we
     -- will signal an error, because every character must have a name.
     character.name = ""

     -- color: The color that we use for lines this character speaks
     -- during a scene.  We expect this to be a table of three integers
     -- representing the red, green, and blue values of the colors,
     -- with values in the 0--255 range.
     character.color = {0, 0, 0}

     -- dialog: This array contains a list of strings representing
     -- everything the character will say.  The says() method adds
     -- strings to this array.
     character.dialog = {}

     -- dialogIndex: This integer is an index for the 'dialog' array
     -- above.  It lets us known what is the current line of dialog we
     -- should display.
     character.dialogIndex = 1

     -- Overwrite any default property values above with ones given to
     -- the constructor.
     for name,value in pairs(properties) do
         if rawget(character, name) ~= nil then
             rawset(character, name, value)
         end
     end

     -- Make sure the character has a name, because we do not support
     -- unnamed characters.
     if character.name == nil or character.name == "" then
         error("Cannot create unnamed character")
     end

     return character
 end

-- This is the method that characters use to speak in scripts.  It
-- adds the given string of text to the 'dialog' property and then
-- returns the entire Character.  We do this because we are very
-- likely calling this method as an argument to another function like
-- LNVL.Scene:new(), which means Lua will evaluate the argument
-- (i.e. call the method) before the logic in the calling function
-- runs.  In those functions we want access to the Character object,
-- and the data given to the character, e.g. here the text to speak.
-- So the only way to get that is to attach the two and then return
-- the entire object so the calling function will get them both.
function LNVL.Character:says(text)
    table.insert(self.dialog, text)
    return self
end

-- Return the class as a module.
return LNVL.Character