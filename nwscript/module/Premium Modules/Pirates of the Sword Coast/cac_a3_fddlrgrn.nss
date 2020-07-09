//::///////////////////////////////////////////////
//:: cac_a3_fddlrgrn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Teleport all PC's to Fiddlers Green.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_generic"

void main()
{
    object oAlledry = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oCursor = GetFirstPC();
    object oWPTarg = GetObjectByTag("A3_FDDLRGRN_STRT");
    location lTarg = GetLocation(oWPTarg);

    // JE: JumpToLocation is not reliable
/*
    if (GetIsPC(oPC) == TRUE)
    {

        while (GetIsObjectValid(oCursor) == TRUE)
        {
            AssignCommand(oCursor, JumpToLocation(lTarg));
            oCursor = GetNextPC();
        }
    }
*/

    JumpPCsToLocation(lTarg, 2);
}
