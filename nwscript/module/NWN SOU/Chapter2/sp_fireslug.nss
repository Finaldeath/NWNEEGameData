//::///////////////////////////////////////////////
//:: Fire Slug (OnSpawn)
//:: Sp_FireSlug.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Fire the slug's UD event on spawn.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 12, 2003
//:://////////////////////////////////////////////

void main()
{
    ActionRandomWalk();
    SignalEvent(OBJECT_SELF, EventUserDefined(5000));
}