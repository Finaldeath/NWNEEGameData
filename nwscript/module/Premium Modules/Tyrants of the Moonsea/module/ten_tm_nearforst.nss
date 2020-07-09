// this is the exit trigger for the random area near elventree (craster)

#include "hf_in_plot"
#include "hf_in_npc"
#include "x0_i0_partywide"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        int nPlot = PlotLevelGet("TheCrippledFangDead");

        // (craster) player is going from Hillsfar to Elventree for the first time
        // force the player to speak with craster
        if (nPlot < 2)
        {
            if (PlotLevelGet("Craster") < 2)
            {
                AssignCommand(oPC, SpeakString("Craster calls out, 'Hey, where are you going?'"));
            }
            else
            {
                TeleportToWaypoint(oPC, "WP_Elventree_To_Hillsfar", FALSE);
            }
        }

        // (karandas) player is going from Cormanthor to Elventree after defeating crippled fang
        // if the player runs away from karandas, allow them to return here later
        // this is done when the player has killed karandas and has looted dominion
        if (nPlot >= 2)
        {
            object oKarandas = GetNearestObjectByTag("Karandas");
            if (!GetIsObjectValid(oKarandas) || GetIsDead(oKarandas))
            {
                if (GetIsItemPossessedByParty(oPC, "Dominion"))
                {
                    PlotLevelSet("TheCrippledFangDead", 3);
                }
            }
            TeleportToWaypoint(oPC, "WP_Elventree_To_Cormanthor", FALSE);
        }
    }
}
