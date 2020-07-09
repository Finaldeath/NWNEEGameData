#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetLastUsedBy();

    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nExit") != 0)
        {
            if (PlotLevelGet("ks_jared") >= 6)
            {
                // Jared leaves after Umgatlik is destroyed
                object oJared = GetObjectByTag("ks_jared");
                if (GetIsObjectValid(oJared))
                {
                    DestroyObject(oJared);
                }
            }
            if (PlotLevelGet("ks_jared") >= 6 || PlotLevelGet("ks_umgatlik") >= 5)
            {
                // workers leave after Umgatlik is destroyed
                int i = 1;
                object oWorker = GetObjectByTag("ks_dig_worker", i);
                while (GetIsObjectValid(oWorker))
                {
                    AssignCommand(oWorker, SetIsDestroyable(TRUE, TRUE, TRUE));
                    DestroyObject(oWorker, 0.5);
                    oWorker = GetObjectByTag("ks_dig_worker", ++i);
                }
            }
            TeleportToWaypoint(oPC, "WP_AR2100_SHRINE_EXIT", TRUE);
        }
        else
        {
            AddJournalQuestEntry("j80", 3, oPC);
            TeleportToWaypoint(oPC, "WP_AR2104_SHRINE_ENTER", TRUE);
        }
    }
}
