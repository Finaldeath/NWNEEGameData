//::///////////////////////////////////////////////
//::
//:: a3_ud_reflect
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: User Defined script for placeables.
//::
//:: Randomly looks for nearby waypoints to apply
//:: lighting effects to - use in watery rooms.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 9/21/2005
//::
//:://////////////////////////////////////////////

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if  (nEvent == 501) // create light fx
    {
        string sReflector = "bw_reflect";
        int nRandom = d10();
        object oReflector = GetNearestObjectByTag(sReflector, OBJECT_SELF, nRandom);

        if (GetIsObjectValid(oReflector))
        {
            float fDur = (d4(3) * 0.1);  // .3 - 1.2 seconds

            effect eFX = GetFirstEffect(oReflector);
            if (GetIsEffectValid(eFX))
            {
                // this reflector object has a light on it, get another...
                nRandom = d10();
                oReflector = GetNearestObjectByTag(sReflector, OBJECT_SELF, nRandom);

                if (GetIsObjectValid(oReflector))
                {
                    eFX = GetFirstEffect(oReflector);
                    if (GetIsEffectValid(eFX))
                    {
                        return; // tried twice, forget this light
                    }
                }
                else return;    // not valid reflector
            }

            effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_BLUE_5);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLight, oReflector, fDur);
        }
    }
}
