//::///////////////////////////////////////////////
//:: m2q2reljournaln
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Dan Whiteside
//:: Created On: May 21, 2001
//:://////////////////////////////////////////////
int StartingConditional()
{
    int iResult;

    iResult = GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(),"M2Q2GJRNRELMAR"));
    return iResult;
}