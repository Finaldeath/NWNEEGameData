//::///////////////////////////////////////////////
//:: FileName sc_ac_ngoldeyes
//:: Make sure the player hasn't already taken the gold pieces from the corpse's eyes
//:://////////////////////////////////////////////
//:: Created By: Anya Calncy
//:: Created On: 2/4/2006 9:04:17 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_goldeyes") != 1))
        return FALSE;

    return TRUE;
}
