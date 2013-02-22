-- This example shows how to present a menu with two choices.  Each
-- choice jumps the story to one of two possible scenes.  This example
-- also demonstrates jumping to other scenes in general.

Eric = LNVL.Character:new{name = "Eric", textColor = "#c8ffc8"}
Jeff = LNVL.Character:new{name = "Jeff", textColor = "#c8c8ff"}
Judge = LNVL.Character:new{name = "The Great Judgini", textColor = "#ffc8c8"}

START = LNVL.Scene:new{
    Jeff "Isn't this copyright infringement again?",
    Eric "Would you just shut up...",
    Judge "I have reviewed the evidence.  How do you plead?",

    -- Each choice has two parts: a line of text to present to the
    -- player, and the name of the scene to jump to if that is the
    -- selection he makes.
    LNVL.Menu:new{
        {"Not Guilty", "NOT_GUILTY"},
        {"Obviously Guilty", "THE_TRUTH"}
    },
}

NOT_GUILTY = LNVL.Scene:new{
    Eric "Not guilty, your Honor.",
    Judge "Denied!  It's opposite day!",
    Jeff "Wait, what the...",
    LNVL.Scene.changeTo("THE_TRUTH"),
}

THE_TRUTH = LNVL.Scene:new{
    Eric "Ok, so we infringed on copyrighted material...",
    Jeff "You did.",
    Judge "Then I hearby sentence you to hard labor in that prison from Rambo 2.",
    Jeff "What?!?",
    Eric "Oh cool, do we get a visit from Richard Crenna?",
    Judge "No.  He died in 2003, remember?",
    Eric "Oh yeah...",
    LNVL.Scene.changeTo("END"),
}

END = LNVL.Scene:new{
    Jeff "I hate you.  I hate you so much.",
    Eric "I love you too buddy.",
    Jeff "So much hate..."
}

-- That is how you make arbitrary jumps to other scenes and poor
-- references to other media.
