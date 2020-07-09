#include "nw_i0_generic"

void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    object oFish;

    location lSelf = GetLocation(oSelf);
    effect eSplash = EffectVisualEffect(137);

    int iDestroyed = GetLocalInt(oSelf, "pus_a3_hole");
    int iDeadCounter = GetLocalInt(oArea, "A3_SEIGE_FISH");
    int iActive = GetLocalInt(oArea, "exe_a3_sgstrt");
    int iCurrentGuards = 0;

    if ((iDestroyed == FALSE) && (iActive == TRUE))
    {
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eSplash, lSelf);

        oFish = GetObjectByTag("a3_seigefish");
        while (GetIsObjectValid(oFish) == TRUE)
        {
            iCurrentGuards++;
            oFish = GetObjectByTag("a3_seigefish", iCurrentGuards);
        }

        if ((iDeadCounter < 25) && (iCurrentGuards < 3))
        {
            oFish = CreateObject(OBJECT_TYPE_CREATURE, "a3_seigefish", lSelf);
            DelayCommand(1.0f, AssignCommand(oFish, DetermineCombatRound()));
        }
    }
}
