//::///////////////////////////////////////////////
//:: FileName sc_ac_ckchsqst6
//:: See if cheese quest is complete (killed Yentai).
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/18/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_cheese_quest") == 6))
        return FALSE;

    return TRUE;
}
