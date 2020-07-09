//::///////////////////////////////////////////////
//:: con_a2_pckpckt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    See if the player has the ability to Pick
    pockets
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPete = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int iPlot = GetLocalInt(GetModule(), "A2_FRANC");
    int iReturn = FALSE;

    if ((GetSkillRank(SKILL_PICK_POCKET, oPC) == TRUE)
        && (iPlot >= 40))
    {
        iReturn = TRUE;
    }

    return iReturn;
}
