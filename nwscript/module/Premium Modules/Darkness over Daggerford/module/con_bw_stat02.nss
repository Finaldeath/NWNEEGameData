//::///////////////////////////////////////////////
//::
//:: con_bw_stat02
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: Conversation script.
//::
//:: Create secret vault door in Hall of Kings.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/7/2005
//::
//:://////////////////////////////////////////////

void main()
{
    object oWP = GetNearestObjectByTag("wp_ar2503_sdoor02_create");
    location lLoc = GetLocation(oWP);

    CreateObject(OBJECT_TYPE_PLACEABLE, "bw_sdoor", lLoc, FALSE, "ar2503_sdoor02");

    SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
}
