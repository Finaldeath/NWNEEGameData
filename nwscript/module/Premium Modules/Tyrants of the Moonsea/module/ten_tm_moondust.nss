//Vial of dust transforms into Moondust in Temple of Selune
#include "x0_i0_partywide"

void main()
{
    object oPC = GetEnteringObject();
    object oDust = GetItemPossessedByParty(oPC, "VialofDust");

    if(GetIsObjectValid(oDust))
    {
        effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);

        AssignCommand(oPC,
            SpeakString("The vial of dust sparkles with divine power as " +
                        "it is brought close to Selûne's holy symbol."));
        DestroyObject(oDust);
        CreateItemOnObject("moondust", oPC);
    }
}
