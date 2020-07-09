//::///////////////////////////////////////////////
//:: con_nattract_d1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the player is not considered attractive
    to the NPC they are speaking too.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oNPC = GetLastSpeaker();

    int iCharisma = GetAbilityModifier(ABILITY_CHARISMA, oPC);
    int iDoOnce = GetLocalInt(oNPC, "con_nattract_d1");
    int iResult = FALSE;

    // if the NPC and PC are not of the same gender, the PC has a +2 Char modifier
    // and this script has never been called for this NPC before return true
    if ((GetGender(oPC) != GetGender(oNPC)) && (iCharisma <= -1) && (iDoOnce == FALSE))
    {
        SetLocalInt(oNPC, "con_nattract_d1", TRUE);
        iResult == TRUE;
    }

    return iResult;
}
