#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        SpawnEnter(oPC);
        effect eMind = EffectVisualEffect(VFX_IMP_SLEEP);
        object oArea = OBJECT_SELF;
        int iObjCount;
        object oObject = GetNearestObjectByTag("dag_sleepmh2",oPC,0);
        location lTarget = GetLocation(oObject);
        while(GetIsObjectValid(oObject))
              {
               ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eMind, lTarget,99.0);
               iObjCount++;
               oObject = GetNearestObjectByTag("dag_sleepmh2",oPC,iObjCount);
               lTarget = GetLocation(oObject);
              }

    }
}
