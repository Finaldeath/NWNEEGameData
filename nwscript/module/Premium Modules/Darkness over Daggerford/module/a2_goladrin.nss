// player blows goladrin's horn

#include "x2_inc_switches"

void Activate(object oPC)
{
    AssignCommand(oPC, PlaySound("as_sw_horn1"));
    AssignCommand(oPC, ActionCastSpellAtObject(SPELL_BATTLETIDE, oPC, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        Activate(GetItemActivator());
    }
}
