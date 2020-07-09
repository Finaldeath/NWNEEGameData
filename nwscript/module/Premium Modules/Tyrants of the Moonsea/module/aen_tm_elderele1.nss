// random area: ship deck for elder water elemental encounter
// sidequest: muragh's magnificent machine

#include "hf_in_plot"
#include "hf_in_util"

void shakeScreen(object oPC)
{
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oPC);
    AssignCommand(oPC, PlaySound("as_cv_woodbreak3"));
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // player has just enetered the area, so the attack begins
        if (PlotLevelGet("ElderWaterElemental") <= 1)
        {
            PlotLevelSet("ElderWaterElemental", 2);

            object oKettia = GetNearestObjectByTag("CaptainKettia", oPC);
            AssignCommand(oKettia, SpeakString("We are under attack!"));
            AssignCommand(oKettia, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, 2.0f));

            DelayCommand(1.0, shakeScreen(oPC));
        }

        // player has defeated the elemental so allow exit
        if (PlotLevelGet("ElderWaterElemental") >= 4)
        {
            object oDoor = GetObjectInArea("dt_ship_navicabi", oPC, 1);
            SetLocked(oDoor, FALSE);
        }
    }
}
