//::////////////////////////////////////////////////////////////////////////////
//:: cac_id1_bossitem
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Conversation action taken script to have the boss creture give the player
    one of his items. The script is generalized to use the tag of the creature
    running it to determine the item that should be given.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Nov 18, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"
#include "inc_id_liltimmy"

void main()
{
    object oPC = GetPCSpeaker();
    string sTag = GetTag(OBJECT_SELF);

    int nFirstLieutenant = lt_GetFirstLieutenant();
    int nSecondLieutenant = lt_GetSecondLieutenant();
    int nThirdLieutenant = lt_GetThirdLieutenant();
    int nFirstBoss = lt_GetFirstBoss();
    int nSecondBoss = lt_GetSecondBoss();
    int nThirdBoss = lt_GetThirdBoss();

    // select the appropriate boss item and set the quest as active
    string sItemTag;
    if (sTag == ANTOINE_TAG) // baccha
    {
        sItemTag = "itm_id1_anttot";
        SetLocalInt(GetModule(), "bBacchaQuestActive", TRUE);
        AddJournalQuestEntry("id1_baccha", 10, oPC, TRUE, TRUE, TRUE);
        if (nFirstLieutenant == ID_LOCAL_LIEUTENANT_WEREBOAR)
        {
            AddJournalQuestEntry("id1_main", 25, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nSecondLieutenant == ID_LOCAL_LIEUTENANT_WEREBOAR)
        {
            AddJournalQuestEntry("id1_main", 35, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nThirdLieutenant == ID_LOCAL_LIEUTENANT_WEREBOAR)
        {
            AddJournalQuestEntry("id1_main", 45, GetFirstPC(), TRUE, TRUE, TRUE);
        }
    } else if (sTag == HAGATHA_TAG) // hagatha
    {
        sItemTag = "itm_id1_widhair";
        SetLocalInt(GetModule(), "bHagathaQuestActive", TRUE);
        AddJournalQuestEntry("id1_hagatha", 10, oPC, TRUE, TRUE, TRUE);
        if (nFirstLieutenant == ID_LOCAL_LIEUTENANT_GIANTESS)
        {
            AddJournalQuestEntry("id1_main", 26, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nSecondLieutenant == ID_LOCAL_LIEUTENANT_GIANTESS)
        {
            AddJournalQuestEntry("id1_main", 36, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nThirdLieutenant == ID_LOCAL_LIEUTENANT_GIANTESS)
        {
            AddJournalQuestEntry("id1_main", 46, GetFirstPC(), TRUE, TRUE, TRUE);
        }
    } else if (sTag == MAGGRIS_TAG) // maggris
    {
        sItemTag = "itm_id1_maggegg";
        SetLocalInt(GetModule(), "bMaggrisQuestActive", TRUE);
        AddJournalQuestEntry("id1_maggris", 10, oPC, TRUE, TRUE, TRUE);
        if (nFirstLieutenant == ID_LOCAL_LIEUTENANT_INSECT)
        {
            AddJournalQuestEntry("id1_main", 27, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nSecondLieutenant == ID_LOCAL_LIEUTENANT_INSECT)
        {
            AddJournalQuestEntry("id1_main", 37, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nThirdLieutenant == ID_LOCAL_LIEUTENANT_INSECT)
        {
            AddJournalQuestEntry("id1_main", 47, GetFirstPC(), TRUE, TRUE, TRUE);
        }
    } else if (sTag == HARAT_TAG) // harat
    {
        sItemTag = "itm_id1_harattg";
        SetLocalInt(GetModule(), "bHaratQuestActive", TRUE);
        AddJournalQuestEntry("id1_harat", 10, oPC, TRUE, TRUE, TRUE);
        if (nFirstBoss == ID_LOCAL_BOSS_DEMON)
        {
            AddJournalQuestEntry("id1_main", 55, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nSecondBoss == ID_LOCAL_BOSS_DEMON)
        {
            AddJournalQuestEntry("id1_main", 65, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nThirdBoss == ID_LOCAL_BOSS_DEMON)
        {
            AddJournalQuestEntry("id1_main", 75, GetFirstPC(), TRUE, TRUE, TRUE);
        }
    } else if (sTag == GZHORB_TAG) // gzhorb
    {
        sItemTag = "itm_id1_gzrbeye";
        SetLocalInt(GetModule(), "bGzhorbQuestActive", TRUE);
        AddJournalQuestEntry("id1_gzhorb", 10, oPC, TRUE, TRUE, TRUE);
        if (nFirstBoss == ID_LOCAL_BOSS_BEHOLDER)
        {
            AddJournalQuestEntry("id1_main", 56, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nSecondBoss == ID_LOCAL_BOSS_BEHOLDER)
        {
            AddJournalQuestEntry("id1_main", 66, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nThirdBoss == ID_LOCAL_BOSS_BEHOLDER)
        {
            AddJournalQuestEntry("id1_main", 76, GetFirstPC(), TRUE, TRUE, TRUE);
        }
    } else if (sTag == MASTERIUS_TAG) // masterius
    {
        sItemTag = "itm_id1_masbone";
        SetLocalInt(GetModule(), "bMasteriusQuestActive", TRUE);
        AddJournalQuestEntry("id1_masterius", 10, oPC, TRUE, TRUE, TRUE);
        if (nFirstBoss == ID_LOCAL_BOSS_LICH)
        {
            AddJournalQuestEntry("id1_main", 57, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nSecondBoss == ID_LOCAL_BOSS_LICH)
        {
            AddJournalQuestEntry("id1_main", 67, GetFirstPC(), TRUE, TRUE, TRUE);
        } else if (nThirdBoss == ID_LOCAL_BOSS_LICH)
        {
            AddJournalQuestEntry("id1_main", 77, GetFirstPC(), TRUE, TRUE, TRUE);
        }
    }

    CreateItemOnObject(sItemTag + "1", oPC, 1, sItemTag + "_dormant");
//    CreateItemOnObject(sItemTag, oPC);
    DebugMessage("Creating " + sItemTag + " on " + GetTag(oPC));
}
