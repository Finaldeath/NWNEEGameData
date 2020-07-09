//Trigger to tip burning oil pot on PC
#include "inc_ktgate"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsEnemy(oPC) && CanSeeCreature(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        //Get the objects involved in pouring the burning oil
        string sPotVar = GetLocalString(OBJECT_SELF, "sPot");

        object oPot = GetObjectByTag(sPotVar);
        object oFlowStart = GetObjectByTag(sPotVar + "Start");
        object oFlowMid = GetObjectByTag(sPotVar + "Chute");
        object oFlowTarget = GetObjectByTag(sPotVar + "Target");
        object oFlowEnd = GetObjectByTag(sPotVar + "Drop");

        effect eFire = EffectAreaOfEffect(AOE_PER_WALLFIRE);
        effect eOil = EffectAreaOfEffect(AOE_PER_GREASE,"****", "****", "****");
        effect eFlow = EffectBeam(444, oFlowStart, BODY_NODE_CHEST);
        effect eFlow2 = EffectBeam(444, oFlowEnd, BODY_NODE_CHEST);

        location lTarget = GetLocation(oFlowTarget);

        SetLocalInt(OBJECT_SELF, "nEntered", 1);

        //Tip the pot and create the burning oil flow
        AssignCommand(oPot, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
        DelayCommand(0.1,
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFlow, oFlowMid, 5.0));
        DelayCommand(0.5,
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFlow2, oFlowTarget, 4.5));
        DelayCommand(1.0,
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eOil, lTarget, 20.0));
        DelayCommand(1.1,
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eFire, lTarget, 20.0));
    }
}
