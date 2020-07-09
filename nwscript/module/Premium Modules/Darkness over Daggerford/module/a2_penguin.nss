// the player drops a penguin
// ... this assumes that the penguin can never be picked up
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
        object oPenguin = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_peng", lLoc);
        AssignCommand(oPenguin, SpeakString("No! Take me to Govan's Grove in the Brush of Barbs!"));
        AssignCommand(oPenguin, PlaySound("c_penguin_hit1"));
        AssignCommand(oPenguin, PlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        DestroyObject(oItem);
    }
}
