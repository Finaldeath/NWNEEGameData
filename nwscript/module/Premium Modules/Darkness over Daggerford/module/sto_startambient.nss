//::///////////////////////////////////////////////
//:: Store Open Script
//:: nw_d1_
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void main()
{
    string sStoreOwner = GetLocalString(OBJECT_SELF,"StoreOwner");
    object oOwner = GetNearestObjectByTag(sStoreOwner);
    SetLocalInt(oOwner,"HF_DISABLE_AM",0);
}