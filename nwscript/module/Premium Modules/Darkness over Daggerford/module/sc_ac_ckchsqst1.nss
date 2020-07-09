//::///////////////////////////////////////////////
//:: FileName sc_ac_ckchsqst1
//:: See if player is on Cheese quest
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/10/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_cheese_quest") == 1))
        return FALSE;

    return TRUE;
}
