//::///////////////////////////////////////////////
//:: FileName sc_ac_sejbandt3
//:: See if player collected Sejellus' reward.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/31/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_sej_bandit") == 3))
        return FALSE;

    return TRUE;
}
