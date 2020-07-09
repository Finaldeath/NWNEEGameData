//::///////////////////////////////////////////////
//:: FileName sc_ac_ckchsqst7
//:: See if player is on Cheese quest and working for Yentai against Millie.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/17/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_cheese_quest") == 7))
        return FALSE;

    return TRUE;
}
