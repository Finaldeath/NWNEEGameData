//::///////////////////////////////////////////////
//:: FileName sc_ac_ckchsqst2
//:: See if player is on Cheese quest and arrived in Gillian's Hill.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/17/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_cheese_quest") >= 2))
        return FALSE;

    return TRUE;
}
