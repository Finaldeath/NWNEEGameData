//::///////////////////////////////////////////////
//:: FileName sc_ac_ckrogue
//:: See if the player is a rogue
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 10:32:10 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetLevelByClass(CLASS_TYPE_ROGUE, GetPCSpeaker()) >= 1)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
