// item event script for "scroll of illusion" that polymorphs you into a human

#include "x2_inc_switches"

void polymorphPlayer(object oPC, object oItem)
{
    SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HUMAN);
    SetLocalInt(oPC, "HF_POLY_CREATURE_TYPE", APPEARANCE_TYPE_HUMAN);
    DestroyObject(oItem);
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
    }

    if (GetIsPC(oPC))
    {
        int nInt = GetLocalInt(oPC, "outsidehillsfar");
        if ((nInt < 1))
        {
            FloatingTextStringOnCreature("*Failed*", oPC);
            SendMessageToPC(oPC, "You should wait until you are closer to Hillsfar before using the scroll.");
        }
        else
        {
            if (GetRacialType(oPC) != RACIAL_TYPE_HUMAN)
            {
                AssignCommand(oPC, ClearAllActions());
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oPC);
                DelayCommand(1.0, polymorphPlayer(oPC, oItem));
            }
            else
            {
                FloatingTextStringOnCreature("*Failed*", oPC);
                SendMessageToPC(oPC, "This does not work on humans.");
            }
        }
    }
}
