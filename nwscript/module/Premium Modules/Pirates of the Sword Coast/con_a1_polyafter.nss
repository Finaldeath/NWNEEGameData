//::///////////////////////////////////////////////
//:: Hench Popup: A1_POLYAFTER_REST
//:: con_a1_polyafter.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Return TRUE if this node's ConvIndex is active.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 6, 2005
//:://////////////////////////////////////////////
const string sConvIndex = "A1_POLYAFTER_REST";

int StartingConditional()
{
    string sCurrentIndex = GetLocalString(OBJECT_SELF, "CONV_INDEX");
    if (sCurrentIndex == sConvIndex)
    {
        return TRUE;
    }
    return FALSE;
}
