//::///////////////////////////////////////////////
//:: con_a1_polycave
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Poly flees beofre entering the slime cave.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sConvIndex = "A1_POLYFLEE_CAVE1";

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();
    string sVar = GetLocalString(oModule, "CONV_INDEX");
    int iDoOnce = GetLocalInt(oModule, sConvIndex);
    int iResult = FALSE;

    if ((sVar == sConvIndex) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, sConvIndex, TRUE);
        SetLocalString(oModule, "CONV_INDEX", "");
        iResult = TRUE;
    }

    return iResult;
}
