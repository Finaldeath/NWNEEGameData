// item event script for Moondust
// on use: creates one Moon Mote per party member which will apply
// heal/restoration to each

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        object oMote;
        object oPartyMember;
        object oPC = GetItemActivator();
        object oItem = GetItemActivated();

        if(GetIsPC(oPC))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
            oPartyMember = GetFirstFactionMember(oPC, FALSE);
            while (GetIsObjectValid(oPartyMember))
            {
                oMote = CreateObject(OBJECT_TYPE_CREATURE, "moonmote", GetLocation(oPC));
                SetLocalObject(oMote, "oTarget", oPartyMember);
                oPartyMember = GetNextFactionMember(oPC, FALSE);
            }
        }
    }
}
