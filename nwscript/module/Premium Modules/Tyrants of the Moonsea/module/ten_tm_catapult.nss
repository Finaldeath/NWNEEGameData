#include "hf_in_plot"
#include "inc_ktgate"

//Trigger to fire catapult at PC
void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0 &&
       CanSeeCreature(oPC) && PlotLevelGet("KTBridgeMissile") == 1)
    {
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        if(d2() == 1)
        {
            AssignCommand(GetNearestObjectByTag("KTCatapult"),
                ActionCastSpellAtLocation(553,
                                          GetRandomMissLocation(oPC),
                                          METAMAGIC_ANY,
                                          TRUE,
                                          PROJECTILE_PATH_TYPE_BALLISTIC,
                                          TRUE));
       }
       else
       {
            AssignCommand(GetNearestObjectByTag("KTCatapult"),
                ActionCastSpellAtObject(553,
                                        oPC,
                                        METAMAGIC_ANY,
                                        TRUE,
                                        0,
                                        PROJECTILE_PATH_TYPE_BALLISTIC,
                                        TRUE));
       }
    }
}
