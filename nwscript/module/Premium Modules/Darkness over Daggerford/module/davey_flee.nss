#include "NW_I0_GENERIC"
void main()
{
    SetLocalInt(GetPCSpeaker(), "ac_davey_quest", 3);
    GiveXPToCreature(GetPCSpeaker(),500);
    SetLocalInt(OBJECT_SELF, "no_banter", 1);
    ActivateFleeToExit();
}
