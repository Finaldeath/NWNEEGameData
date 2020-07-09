//Area OnEnter for Kur-Tharsu Ground Floor - set NPC Plot variables

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    //Update journal and give quest completion xp
    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        int nXP;

        AddJournalQuestEntry("AssaultonKurTharsu", 40, oPC);
        nXP = GetJournalQuestExperience("AssaultonKurTharsu");
        GiveXPToCreature(oPC, nXP);
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
    }

    if(GetIsPC(oPC) && PlotLevelGet("Blizzard") >= 10 & PlotLevelGet("Blizzard") < 16)
    {
        PlotLevelSet("Blizzard", 16);
    }

    if(GetIsPC(oPC) && PlotLevelGet("Elf") >= 15 & PlotLevelGet("Elf") < 20)
    {
        PlotLevelSet("Elf", 20);
    }
}
