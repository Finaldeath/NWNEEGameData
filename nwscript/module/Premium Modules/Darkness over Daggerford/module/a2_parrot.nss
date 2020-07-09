// the player drops a parrot
// ... this assumes that the parrot can never be picked up
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
        object oParrot = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_parrot", lLoc);
        AssignCommand(oParrot, SpeakString("No! Take me to Govan's Grove in the Brush of Barbs!"));
        AssignCommand(oParrot, PlaySound("c_parrot_slct"));
        AssignCommand(oParrot, PlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        DestroyObject(oItem);
    }
}
