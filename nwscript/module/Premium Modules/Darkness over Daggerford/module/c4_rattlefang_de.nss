// onDeath script for rattlefang, the gnoll leader

#include "hf_in_xp"

void main()
{
    object oPC = GetFirstPC();
    SetLocalInt(oPC, "nWH_RattlefangDead", 1);

    int j = 0;
    //Killed ogres and told to kill gnolls
    if ((GetLocalInt(oPC, "nWH_BonesnapDead") == 1) &&
        (GetLocalInt(oPC, "nWH_SpokeGnolls") > 0 ||
         GetLocalInt(oPC, "nWH_OgreDeal") > 0))
    {
        j = 19;
        GiveQuestXPToCreature(oPC, "j204", 100.0);
    }
    else if (GetLocalInt(oPC, "nWH_OgreDeal") > 0)
    {
        // promised ogres to kill gnolls
        j = 11;
    }
    //asked to kill gnolls but killed gnolls
    else if (GetLocalInt(oPC, "nWH_SpokeGnolls") > 0)
    {
        j = 9;
    }

    if(j > 0)
    {
        AddJournalQuestEntry("j204", j, oPC);
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
