//:://////////////////////////////////////////////
//::
//:: On Enter script for triggers.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/7/2005
//::
//:://////////////////////////////////////////////

#include "hf_in_spawn"
#include "hf_in_henchman"
#include "hf_in_xp"
#include "nw_i0_spells"

void SealDoor(object oDoor, object oPC);

void BeholderBuff(object oCreature);

void main()
{
    object oEnterer = GetEnteringObject();
    string sTag = GetTag(OBJECT_SELF);

    if (sTag == "bw_fire_trig")
    {
        object oFlamer = GetNearestObjectByTag("bw_flamer");
        if (GetIsObjectValid(oFlamer))
        {
            SignalEvent(oFlamer, EventUserDefined(500)); // burn!
        }
    }
    else if (GetIsPC(oEnterer))
    {
        if (sTag == "ar2501a_trig02")
        {
            // player has just entered illefarn
            // ... door locks and veiti talks
            object oDoor = GetNearestObjectByTag("ar2501a_ar2500_exit");

            if (GetLocalInt(oDoor, "nBeenSealed") == 0)
            {
                SealDoor(oDoor, oEnterer);
                object oVeiti = GetNearestObjectByTag("db_veiti", oEnterer);
                if (GetIsObjectValid(oVeiti))
                {
                    // make sure veiti is a henchman (should always be true)
                    if (GetMaster(oVeiti) != oEnterer)
                    {
                        HenchmanHire(oVeiti, oEnterer);
                    }

                    // make this veiti's "return to when abandoned dead" point
                    // .. this isn't a very good spot, but it's better than
                    // .. outside the illefarn doors which will never open again!
                    HenchmanSetHome(oVeiti, GetLocation(oVeiti));

                    // veiti banters
                    HenchmanBanter(oVeiti, 1);

                    // update "dwarves of illefarn" journal
                    AddJournalQuestEntry("j16", 3, oEnterer);
                }
            }
        }
        else if (sTag == "ar2501a_trig01")
        {
            // player has walked onto the bridge after entering illefarn
            // ... some zhents are talking
            if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nDone", 1);
                object oZhent1 = GetNearestObjectByTag("ks_ill_zhent1", oEnterer);
                SignalEvent(oZhent1, EventUserDefined(1));

                // listen skill check is always successful
                string sText = "You hear voices on the far side of the bridge.";
                AssignCommand(oEnterer, ClearAllActions());
                AssignCommand(oEnterer, PlaySound("gui_magbag_full"));
                FloatingTextStringOnCreature("... [Listen] Skill Check: Success ...", oEnterer);
                DelayCommand(1.25, AssignCommand(oEnterer, SpeakString(sText)));

                // update "dwarves of illefarn" journal
                AddJournalQuestEntry("j16", 5, oEnterer);
            }
        }
        else if (sTag == "ar2501a_trig03")
        {
            // player has walked past the bridge after entering illefarn
            // ... the zhent dwarf-disposers will attack now that they see
            // ... the player
            object oZhent1 = GetNearestObjectByTag("ks_ill_zhent1", oEnterer);
            object oZhent2 = GetNearestObjectByTag("ks_ill_zhent2", oEnterer);
            SignalEvent(oZhent1, EventUserDefined(9));
            SignalEvent(oZhent2, EventUserDefined(9));
            DestroyObject(OBJECT_SELF);
        }
        else if (sTag == "ar2502_trig1")
        {
            object oArea = GetArea(OBJECT_SELF);
            if (GetLocalInt(oArea, "nIH_BeamActive") == 1)
            {
                object oMirror = GetNearestObjectByTag("bw_mirror_08");
                object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oMirror);
                float fDist = GetDistanceBetween(oMirror, oPC);

                if (fDist > 20.0f) // no pc's near mirror puzzle
                {
                    SetLocalInt(oArea, "nIH_BeamActive", 0);
                }
            }
        }
        else if (sTag == "c1ar2502_enc01")
        {
            if (GetLocalInt(OBJECT_SELF, "nActivated") == 0)
            {
                effect eFire = EffectVisualEffect(VFX_FNF_FIREBALL);
                object oWP = GetNearestObjectByTag("ENC_c1ar2502_enc01");
                location lLoc = GetLocation(oWP);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFire, lLoc);

                SetLocalInt(OBJECT_SELF, "nActivated", 1);

                SpawnEnter(oEnterer);
            }
        }
        else if (sTag == "c1ar2503_enc3")
        {
            object oFissure = GetNearestObjectByTag("ar2503_fissure");
            if (GetIsObjectValid(oFissure))
            {
                SpawnEnter(oEnterer);
            }
        }
        else if (sTag == "c1ar2503_enc4")
        {
            if (GetLocalInt(OBJECT_SELF, "nSummoned") == 0)
            {
                if (GetLocalInt(GetModule(), "nIH_RobbedTomb") == 1)
                {
                    SpawnEnter(oEnterer);

                    effect ePoof = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
                    object oWP = GetNearestObjectByTag("ENC_c1ar2503_enc4");
                    location lLoc = GetLocation(oWP);
                    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePoof, lLoc);

                    SetLocalInt(OBJECT_SELF, "nSummoned", 1);
                }
            }
        }
        else if (sTag == "c1ar2503_trig1")
        {
            if (GetLocalInt(OBJECT_SELF, "nSpoke") == 0)
            {
                object oStat = GetNearestObjectByTag("bw_tombstat");

                AssignCommand(oEnterer, ClearAllActions());
                AssignCommand(oStat, ActionStartConversation(oEnterer));

                SetLocalInt(OBJECT_SELF, "nSpoke", 1);
            }
        }
        else if (sTag == "ar2504_trig01")
        {
            object oBeholder = GetObjectByTag("bw_beholder");

            if (GetIsObjectValid(oBeholder) && !GetIsDead(oBeholder))
            {
                if (!GetIsEnemy(oEnterer, oBeholder))
                {
                    if (GetArea(oBeholder) != GetArea(OBJECT_SELF))
                    {
                        // this pc made a deal with the beholder
                        // move him here now, and activate trog encounter

                        object oEnc = GetNearestObjectByTag("ar2504_trig03");
                        SetLocalInt(oEnc, "nActive", 1);

                        // check for journal update
                        string sJournal = "j19"; // relevant quest
                        int nStatus = 3;          // status

                        string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
                        if (GetLocalInt(oEnterer, sJournalVar) < nStatus)
                        {
                            // player needs an update
                            AddJournalQuestEntry(sJournal, nStatus, oEnterer);
                        }

                        object oBWP = GetObjectByTag("wp_ar2504_behold");

                        BeholderBuff(oBeholder);

                        AssignCommand(oBeholder, ClearAllActions(TRUE));
                        AssignCommand(oBeholder, ActionJumpToObject(oBWP));
                        AssignCommand(oBeholder, ActionSpeakString("My trogs will feast on your flesh, invaders!"));
                    }
                }
            }
        }
        else if (sTag == "ar2504_trig02")
        {
            object oBeholder = GetNearestObjectByTag("bw_beholder");

            if (GetIsObjectValid(oBeholder) && !GetIsDead(oBeholder))
            {
                if (!GetIsEnemy(oEnterer, oBeholder))
                {
                    if (GetArea(oBeholder) == GetArea(OBJECT_SELF))
                    {
                        // beholder may turn
                        object oDrath = GetNearestObjectByTag("bw_dratharion");
                        if (!GetIsObjectValid(oDrath) || GetIsDead(oDrath))
                        {
                            if (!GetIsInCombat(oBeholder))
                            {
                                object oArea = GetArea(OBJECT_SELF);
                                SignalEvent(oArea, EventUserDefined(500)); // beholder turns
                            }
                        }
                    }
                }
            }
        }
        else if (sTag == "ar2504_trig04")
        {
            if (GetLocalInt(OBJECT_SELF, "nBeholderArrived") == 1)
            {
                object oBeholder = GetNearestObjectByTag("bw_beholder");

                if (!GetIsObjectValid(oBeholder) || GetIsDead(oBeholder))
                {
                    // check for journal update
                    string sJournal = "j19"; // relevant quest
                    int nStatus = 5;          // status

                    string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
                    if (GetLocalInt(oEnterer, sJournalVar) < nStatus)
                    {
                        // player needs an update
                        AddJournalQuestEntry(sJournal, nStatus, oEnterer);

                        // player needx XP for quest completion
                        int nXP = GetJournalQuestExperience(sJournal);
                        if (nXP > 0)
                        {
                            //GiveXPToCreature(oEnterer, nXP);
                            GiveQuestXPToCreature(oEnterer, sJournal, 100.0);
                        }
                    }
                }
            }
        }
        else if (sTag == "bw_block_trig")
        {
            object oDoor = GetNearestObjectByTag("bw_blocked");

            if (GetIsObjectValid(oDoor) && GetLocked(oDoor))
            {
                // this door might be blocked
                int nNth = 1;
                object oBlocker = GetNearestObjectByTag("bw_blocker", oDoor, nNth);
                int nBlocked = 0;
                float fDist = GetDistanceBetween(oDoor, oBlocker);

                while (GetIsObjectValid(oBlocker) && (nBlocked == 0))
                {
                    if ((fDist < 5.0f) && (fDist >= -0.0f))
                    {
                        if (GetCurrentHitPoints(oBlocker) > 0)
                        {
                            nBlocked = 1;
                        }
                    }
                    nNth += 1;
                    oBlocker = GetNearestObjectByTag("bw_blocker", oDoor, nNth);
                    fDist = GetDistanceBetween(oDoor, oBlocker);
                }

                if (nBlocked == 0)
                {
                    SetLocked(oDoor, FALSE);
                }
            }
        }
        else if (sTag == "bw_journal_trig")
        {
            string sName = GetName(OBJECT_SELF);
            string sJournal = GetStringLeft(sName, 3);
            string sStatus = GetStringRight(sName, 2);
            int nStatus = StringToInt(sStatus);

            string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
            if (GetLocalInt(oEnterer, sJournalVar) < nStatus)
            {
                // player needs an update
                AddJournalQuestEntry(sJournal, nStatus, oEnterer);
            }
        }
    }
}

void SealDoor(object oDoor, object oPC)
{
    SetLocalInt(oDoor, "nBeenSealed", 1);

    AssignCommand(oPC, ClearAllActions());

    effect eFX = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, oDoor);

    effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_PURPLE);
    DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, oDoor));
    DelayCommand(0.3f, AssignCommand(oDoor, ActionCloseDoor(oDoor)));
    DelayCommand(0.5f, FloatingTextStringOnCreature("The door just closed!", oPC));
}

void BeholderBuff(object oCreature)
{
    effect eSlow = EffectSlow();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oCreature, 300.0f);
    effect eACUp = EffectACIncrease(10);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACUp, oCreature, 300.0f);
}
