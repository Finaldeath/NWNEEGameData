//::///////////////////////////////////////////////
//:: con_a3_drgprtss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the Broze dragon has mentioned the
    Priestess of Umberlee.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oDragon = OBJECT_SELF;
    int iPriestess = GetLocalInt(oDragon, "cac_a3_drgprtss");

    if(iPriestess == TRUE)
    {
        return TRUE;
    }

    return FALSE;
}
