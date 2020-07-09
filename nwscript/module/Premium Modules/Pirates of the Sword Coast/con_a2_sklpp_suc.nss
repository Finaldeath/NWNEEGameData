//::///////////////////////////////////////////////
//:: con_a2_sklpp_suc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Do a skill check on a pick pocket for Rascally
    Pete's ring.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oPete = OBJECT_SELF;
    object oRing = GetItemPossessedBy(oPete, "a2_petering");
    int iDifficulty = GetLocalInt(oPete, "SKILL_PICKPOCKET_DC");
    int iReturn = FALSE;

    if ((GetIsSkillSuccessful(oPC, SKILL_PICK_POCKET, iDifficulty) == TRUE)
        && (GetIsObjectValid(oRing) == TRUE))
    {
        iReturn = TRUE;
    }

    return iReturn;

}
