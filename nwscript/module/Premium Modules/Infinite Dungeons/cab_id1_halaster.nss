//::///////////////////////////////////////////////
//:: cab_id1_halaster
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Halaster conversation - abort script.

    This takes care of a case where the 1st
    Halaster is removed (technically just has
    cutscene invisibility applied), and if the
    player aborts the conversation after this
    point they can't restart it. So we run
    the script that resets things and sends the
    players back to the warehouse.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 9, 2006
//:://////////////////////////////////////////////

void main()
{
    if(GetLocalInt(OBJECT_SELF, "halconv_point_of_no_return"))
    {
        ExecuteScript("cac_id1_endhalas", OBJECT_SELF);
    }
}
