//::///////////////////////////////////////////////
//:: Witch's Wake: Door Open
//:: WW_Door_Open.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Cause a door to unlock and open itself.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: September 3, 2004
//:://////////////////////////////////////////////

void main()
{
    SetLocked(OBJECT_SELF, FALSE);
    ActionOpenDoor(OBJECT_SELF);
}