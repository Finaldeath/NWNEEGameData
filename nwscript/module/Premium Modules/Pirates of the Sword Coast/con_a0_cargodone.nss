//:://////////////////////////////////////////////
//:: con_a0_cargodone
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the Cargo Plot Complete?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iCargo = GetLocalInt(GetModule(), "A0_CARGOPLOTDONE");

    if(iCargo == TRUE)
    {
        return TRUE;
    }

    return FALSE;

}
