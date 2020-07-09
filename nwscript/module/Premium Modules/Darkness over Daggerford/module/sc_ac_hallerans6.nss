//::///////////////////////////////////////////////
//:: FileName sc_ac_halleranso
//:: Check whether player decided to let Hallerans fend for themselves.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/22/2006 2:42:44 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if((GetLocalInt(GetPCSpeaker(), "hallerans_ool") == 1) &&
       GetLocalInt(GetPCSpeaker(), "ac_davey_quest") != 6)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
