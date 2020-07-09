// the player drops a chicken
// ... this assumes that the chicken can never be picked up
// ... after spawning in the grove.

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    if (nEvent == X2_ITEM_EVENT_UNACQUIRE)
    {
        object oItem = GetModuleItemLost();
        object oPC = GetFirstPC();
        location lLoc = GetLocation(oPC);
        object oChicken = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_chick", lLoc);
        AssignCommand(oChicken, SpeakString("No! *cluck* Take me to the grove!"));
        AssignCommand(oChicken, PlaySound("as_an_chickens1"));
        AssignCommand(oChicken, PlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        DestroyObject(oItem);
    }
}
