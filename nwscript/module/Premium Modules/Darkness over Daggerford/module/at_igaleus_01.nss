// the player has released igaleus and the slaves from the slave pen

#include "hf_in_xp"

void flee(object oNPC)
{
    SetLocalString(oNPC, "HF_EXIT_NAME", "WP_AR1900_SLAVE_EXIT");
    SetLocalInt(oNPC,    "HF_EXIT_CHAIN", 1);
    SetLocalInt(oNPC,    "HF_EXIT_RUN", 1);
    ExecuteScript("hf_cs_exit", oNPC);
}

void main()
{
    // update journal and give XP
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("j89", 2, oPC);
    GiveQuestXPToCreature(oPC, "j89");

    // igaleus takes the key
    object oKey = GetItemPossessedBy(oPC, "ks_it_lizkey");
    DestroyObject(oKey);

    // destroy the pen wall
    object oWall = GetNearestObjectByTag("ks_pl_lizwall", oPC);
    DestroyObject(oWall);

    // all the slaves run away
    int i = 1;
    object oSlave = GetNearestObjectByTag("ks_lizslave", oPC, i);
    while (GetIsObjectValid(oSlave))
    {
        flee(oSlave);
        oSlave = GetNearestObjectByTag("ks_lizslave", oPC, ++i);
    }

    // igaleus runs away
    flee(OBJECT_SELF);
}
