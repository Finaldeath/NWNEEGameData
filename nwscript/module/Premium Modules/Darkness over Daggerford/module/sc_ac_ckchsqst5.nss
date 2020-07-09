//::///////////////////////////////////////////////
//:: FileName sc_ac_ckchsqst5
//:: See if player has killed Yentai for Millie.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/18/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_cheese_quest") == 5))
        return FALSE;

    return TRUE;
}
