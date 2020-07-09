// custom death script for bonesnap the ogre king

#include "hf_in_xp"

void main()
{
    object oPC = GetFirstPC();
    SetLocalInt(oPC, "nWH_BonesnapDead", 1);

    int j = 0;
    //Killed gnolls and told to kill ogres or gnolls
    if ((GetLocalInt(oPC, "nWH_RattlefangDead") == 1) &&
        (GetLocalInt(oPC, "nWH_SpokeGnolls") > 0 ||
         GetLocalInt(oPC, "nWH_OgreDeal") > 0))
    {
        j = 19;
        GiveQuestXPToCreature(oPC, "j204", 100.0);
    }
    else if (GetLocalInt(oPC, "nWH_SpokeGnolls") > 0)
    {
        // promised gnolls to kill ogres
        j = 15;
    }
    //asked to kill ogres but killed ogres
    else if (GetLocalInt(oPC, "nWH_OgreDeal") > 0)
    {
        j = 7;
    }

    if(j > 0)
    {
        AddJournalQuestEntry("j204", j, oPC);
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
