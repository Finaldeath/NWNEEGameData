//::///////////////////////////////////////////////
//:: cac_id1_halsurr
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Halaster has surrendered. This fires off of
    a one-liner conversation, which in this case
    is a little odd, but is easiest since this
    is how the existing systems work.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oArea = GetArea(OBJECT_SELF);

    // technically, it's possible for this script to trigger more than once,
    // though you have to kill Halaster super fast to do it. This might not
    // even be possible in normal play, and the consequence is just an extra
    // fade-out... but the fix is easy, so I might as well implement it.

    if(!GetLocalInt(oArea, "fired_surrender_scene"))
    {
        // for this scene we don't want to use the restore-pc-location funcitonality
        cs_SetOption(CS_OPTION_RESTORE_PC_LOCATION, FALSE, oArea);
        cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FASTEST, oArea);
        cs_StartCutscene("cut_id1_hlsd", "cut_id1_hlsd_e", 1.0, FALSE, TRUE, 2, oArea);

        SetLocalInt(oArea, "fired_surrender_scene", TRUE);
        AssignCommand(oArea, DelayCommand(3.0, DeleteLocalInt(oArea, "fired_surrender_scene")));
    }
}
