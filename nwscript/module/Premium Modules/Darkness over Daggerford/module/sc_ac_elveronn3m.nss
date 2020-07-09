//::///////////////////////////////////////////////
//:: FileName sc_ac_elveronne3
//:: Check whether Muriel is downstairs for 2nd time
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "muriel_downstairs") == 3))
        return FALSE;

    return TRUE;
}
