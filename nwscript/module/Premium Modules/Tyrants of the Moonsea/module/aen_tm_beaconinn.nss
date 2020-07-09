// player enters beacon inn: play some flavor text

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // sidequest "thentia's resistance army - the player has not dealt with bale yet
        if (PlotLevelGet("Bale") < 3)
        {
            object oBale = GetNearestObjectByTag("Bale", oPC);
            if (GetIsObjectValid(oBale))
            {
                if (!GetIsDead(oBale))
                {
                    AssignCommand(oBale, ActionSpeakString("Attention! Gather around me!"));
                    AssignCommand(oBale, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
                    AssignCommand(oBale, PlaySound("as_pl_tavtoastm1"));
                }
            }
        }
    }
}
