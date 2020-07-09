//Iyrauroth's Domain OnEnter - update journal and remove Merrik encounter

#include "hf_in_plot"
#include "hf_in_npc"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        if (PlotLevelGet(PLOT_HENCH_DIALOG) < 12)
            PlotLevelSet(PLOT_HENCH_DIALOG, 12);

        AddJournalQuestEntry("AssaultonKurTharsu", 20, oPC);
        //Remove Merrik encounter from Shind Road - Outside Yulash
        DestroyObject(GetObjectByTag("Merrik"));
        DestroyObject(GetObjectByTag("CaptainHaliator"));
        DestroyObject(GetObjectByTag("RedPlumeMercenary1"));
        DestroyObject(GetObjectByTag("RedPlumeMercenary2"));
        DestroyObject(GetObjectByTag("FlavorYulashTrigger"));
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
    }

    if(GetIsPC(oPC))
    {
        //Factions may have been affected by Zhents combat with dragon or wyverns
        ResetFactionReputation(oPC, oPC);
    }
}
