// This will make the initial farmer in daggerford appear if the PC leaves this trigger
// to be placed on the onexit event of a trigger

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    object oFarmer = GetObjectByTag("pm_farmer");
    if (GetIsPC(oPC) && !GetLocalInt(OBJECT_SELF, "trigger_fired") &&
        !GetLocalInt(GetModule(),"hevesar_met")
        && GetLocalInt(GetModule(),"lock_down"))
    {
        SetLocalInt(OBJECT_SELF, "trigger_fired", 1);
        AssignCommand(oPC, ClearAllActions(TRUE));
        CutscenePlay(oPC, "mv_ar0500_4");
     }
}
