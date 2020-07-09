//::///////////////////////////////////////////////
//:: FileName sc_ac_ckchsqst4
//:: See if player is on Cheese quest and working for Millie to kill Yentai.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/17/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_cheese_quest") >= 4))
        return FALSE;

    return TRUE;
}
