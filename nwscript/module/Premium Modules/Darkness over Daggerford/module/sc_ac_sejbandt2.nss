//::///////////////////////////////////////////////
//:: FileName sc_ac_sejbandt2
//:: See if player killed the bandits on Gillian's Hill.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/31/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_sej_bandit") == 2))
        return FALSE;

    return TRUE;
}
