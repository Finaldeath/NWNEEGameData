//::///////////////////////////////////////////////
//:: cac_a2_tasleave2
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player chose to attack Tasina.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 17/05
//:://////////////////////////////////////////////
//:: Modified By: Keith K2 Hayward
//:: Modified On: March 21/05
//:: Added a variable to track if the PC was kind
//:: or cruel to Tasina (Checked in Act 3).
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_global"
#include "nw_i0_generic"

void FightOrFlee(object oCreature);
void Attack(object oCreature);

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    int iRosePlot = GetLocalInt(oModule, "A2_MIDROSE");
    int iSkllPlot = GetLocalInt(oModule, "A2_NECRO");
    int iEXP = GetJournalQuestExperience("a2_spndrf");
    iEXP = ConvertPercent(iEXP, 0.30f);

//// ADDED BY K2 - March 21/05 -----------------
    SetLocalInt(oModule, "POTSC_A2_TASINAHOSTILE", TRUE);
    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_SPNDRF", 70);
    AddJournalQuestEntry("a2_spndrf", 70, oPC);

    SetLocalInt(oModule, "A2_MIDROSE", 40);
    AddJournalQuestEntry("a2_midrose", 40, oPC);

    if (iSkllPlot == 20)
    {
        SetLocalInt(oModule, "A2_NECRO", 30);
        AddJournalQuestEntry("a2_necro", 30, oPC);
    }
//// ADDED BY K2 - March 21/05 -----------------

    // this conversation is a part of the first cutscene, we now need to end it
    object oArea = GetArea(OBJECT_SELF);
    cs_ResetDelay(-1.0, 0.0, oArea, 1);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FASTEST, oArea, 1);
    cs_EndCutscene(0.1, FALSE, TRUE, FADE_SPEED_FAST, 1, oArea);

    // activate trigger, so it'll react to Tasina and the priestesses
    object oTrig = GetObjectByTag(a2t_temple_portal);
    SetLocalInt(oTrig, l_n_A2_TEMPLE_PORTAL_OUT_ACTIVE, TRUE);

    // portallicious
    object oWP_Portal = GetWaypointByTag(a2w_BeneathTemple_Portal);
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, a2p_temple_portal_spawn, GetLocation(oWP_Portal));
    effect eVFX1 = EffectVisualEffect(VFX_DUR_SPELLTURNING);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eVFX1, oPortal);
    //DestroyObject(oPortal, 20.0); // it'll last 20.0s, then go poof
    // changed our minds, it'll stick around forever, the player will be able to use it

    int nPriestessCount = GetLocalInt(oArea, l_n_A2_TEMPLE_PRIESTESS_COUNT);
    int nSahClericCount = GetLocalInt(oArea, l_n_A2_TEMPLE_SAHCLERIC_COUNT);
    int nSahGuardCount = GetLocalInt(oArea, l_n_A2_TEMPLE_SAHGUARD_COUNT);
    int nIndex = 0;

    for(nIndex=0 ; nIndex < nPriestessCount ; nIndex++)
    {
        FightOrFlee(GetObjectArray(oArea, l_oa_A2_TEMPLE_PRIESTESS_ARRAY, nIndex));
    }
    for(nIndex=0 ; nIndex < nSahClericCount ; nIndex++)
    {
        FightOrFlee(GetObjectArray(oArea, l_oa_A2_TEMPLE_SAHCLERIC_ARRAY, nIndex));
    }
    for(nIndex=0 ; nIndex < nSahGuardCount ; nIndex++)
    {
        FightOrFlee(GetObjectArray(oArea, l_oa_A2_TEMPLE_SAHGUARD_ARRAY, nIndex));
    }

    object oTasina = GetObjectByTagInArea(a2c_tag_Tasina, oArea);
    // the fight variable won't be set on Tasina, so she'll flee
    DelayCommand(0.5, FightOrFlee(oTasina));

    DelayCommand(1.0, AssignCommand(oTasina, SpeakString(s_A2_TASINA_FLEE)));
    DelayCommand(1.5, AssignCommand(GetObjectArray(oArea, l_oa_A2_TEMPLE_SAHGUARD_ARRAY, 0), SpeakString(s_A2_TASINA_GUARD)));
}

void FightOrFlee(object oCreature)
{
    int bFight = GetLocalInt(oCreature, l_n_A2_TEMPLE_STAYING_TO_FIGHT);
    if(bFight)
    {
        SetPlotFlag(oCreature, FALSE);
        // we'll put a slight delay on them going hostile
        DelayCommand(1.0, Attack(oCreature));
    }
    else
    {
        SetLocalInt(oCreature, "NO_TALKIE", TRUE);
        // the plot flag ensures that they won't get killed, and more
        // importantly that they won't run their combat scripting
        SetPlotFlag(oCreature, TRUE);
        // the cutscene ghost effect will ensure the creatures who are
        // escaping don't get stuck on other creatures
        effect eCutGhost = EffectCutsceneGhost();
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCreature);

        AssignCommand(oCreature, ClearAllActions(TRUE));

        object oWP1 = GetWaypointByTag(a2w_BeneathTemple_Flee1);
        object oWP2 = GetWaypointByTag(a2w_BeneathTemple_Flee2);
        object oWP3 = GetWaypointByTag(a2w_BeneathTemple_Portal);
        if(GetTag(oCreature) != a2c_tag_Tasina)
        {
            // Tasina doesn't need to go to this waypoint first
            AssignCommand(oCreature, DelayCommand(1.0, ActionMoveToObject(oWP1, TRUE)));
        }
        AssignCommand(oCreature, DelayCommand(1.1, ActionMoveToObject(oWP2, TRUE)));
        AssignCommand(oCreature, DelayCommand(1.2, ActionMoveToObject(oWP3, TRUE)));

        // fail-safe - it shouldn't take too long to get there, if it takes
        // too long just destroy them
        // not sure if the AssignCommand is really needed, but the object
        // running this script should be destroyed before the 20.0s is up
        AssignCommand(oCreature, DestroyObject(oCreature, 20.0));
    }
}

void Attack(object oCreature)
{
    ChangeToStandardFaction(oCreature, STANDARD_FACTION_HOSTILE);
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oCreature);
    if(GetDistanceBetween(oPC, oCreature) > 10.0)
    {
        // if too far away, get closer
        AssignCommand(oCreature, ActionMoveToObject(oPC, TRUE, 7.0));
    }
    else
    {
        // if close enough, kick the pc's ass
        AssignCommand(oCreature, DetermineCombatRound(oPC));
    }
}
