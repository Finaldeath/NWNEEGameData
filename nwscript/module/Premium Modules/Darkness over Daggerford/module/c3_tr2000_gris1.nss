// the player is walking away from griswald; if griswald is suicidal,
// ... make sure he runs up to the gates and kills himself
// ... unless he is already doing that!

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            if (PlotLevelGet("ks_griswald") == 4)
            {
                object oGriswald = GetNearestObjectByTag("ks_griswald", oPC);
                if (GetIsObjectValid(oGriswald))
                {
                    if (!GetIsDead(oGriswald))
                    {
                        if (GetLocalInt(oGriswald, "HF_EXIT_RUN") == 0)
                        {
                            // he is not running; make him run
                            ExecuteScript("at_griswald_03", oGriswald);
                            SetLocalInt(OBJECT_SELF, "nDone", 1);
                        }
                    }
                }
            }
        }
    }
}
