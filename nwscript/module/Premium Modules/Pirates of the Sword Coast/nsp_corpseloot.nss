//::///////////////////////////////////////////////
//:: Auto Death and Lootable Corpse
//:: nsp_corpseloot
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Kills the object on spawn and makes it lootable.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
void main()
{
    effect eDead = EffectDeath();

    // Set the lootable flag then kill the object
    SetLootable(OBJECT_SELF, TRUE);
    SetIsDestroyable(FALSE, FALSE, TRUE);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDead, OBJECT_SELF);
}
