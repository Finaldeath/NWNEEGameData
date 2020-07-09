//::///////////////////////////////////////////////
//:: cex_a0_mbsh30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has wandered into Dela's trap, activate
    the defences
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "nw_i0_generic"
#include "_inc_generic"

void StartWall(float fDuration);
void SummonAllies(int iLevel);

void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetObjectByTag("VFX_NODE", 1);
    int iLevel = GetFactionAverageLevel(oPC);

    if(GetIsPCNotDM(oPC) == TRUE)
    {
        // Summon the hostiles and the fire wall
        SummonAllies(iLevel);

        ActionCastFakeSpellAtObject(SPELL_WALL_OF_FIRE, oTarget);
        DelayCommand(1.0f, ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE));
        DelayCommand(1.8f, StartWall(25.0f));
        DelayCommand(2.3f, DetermineCombatRound());

        //HandoutQuestXP(oPC, iEXP);
        AddJournalQuestEntry("a0_ambush", 30, oPC);
        SetLocalInt(GetModule(), "A0_AMBUSH", 30);
    }
}

void StartWall(float fDuration)
{
    effect eFire = EffectAreaOfEffect(AOE_PER_WALLFIRE);
    //effect eBlade = EffectAreaOfEffect(AOE_PER_WALLBLADE);
    object oNode = GetObjectByTag("VFX_NODE", 0);
    int iCount = 1;

    //Make the wall of fire
    while (GetIsObjectValid(oNode) == TRUE)
    {
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eFire, GetLocation(oNode), fDuration);
        oNode = GetObjectByTag("VFX_NODE", iCount++);
    }
}

void SummonAllies(int iLevel)
{
    object oDoor1 = GetObjectByTag("SPECIAL_DELA", 0);
    object oDoor2 = GetObjectByTag("SPECIAL_DELA", 1);
    object oSpawn1 = GetObjectByTag("DELA_HENCHSPAWN", 0);
    object oSpawn2 = GetObjectByTag("DELA_HENCHSPAWN", 1);
    object oWayPoint = GetWaypointByTag("MP_DELACON");
    object oAttacker;
    int iHitDice = 1;

    // open the nearby doors
    SetLocked(oDoor1, FALSE);
    SetLocked(oDoor2, FALSE);
    AssignCommand(oDoor1, ActionOpenDoor(OBJECT_SELF));
    AssignCommand(oDoor2, ActionOpenDoor(OBJECT_SELF));

    //Create some thugs, move them out into the open, and have them attack
    oAttacker = CreateObject(OBJECT_TYPE_CREATURE, "ao_delamugger", GetLocation(oSpawn1));
    iHitDice = GetHitDice(oAttacker);
    while (iHitDice < (iLevel - 2) )
    {
        iHitDice = LevelUpHenchman(oAttacker);
    }

    DelayCommand(0.5f, AssignCommand(oAttacker, ActionMoveToObject(oWayPoint, TRUE, 2.0f)));
    DelayCommand(1.0f, AssignCommand(oAttacker, DetermineCombatRound()));

    oAttacker = CreateObject(OBJECT_TYPE_CREATURE, "a0_delathug", GetLocation(oSpawn2));
    iHitDice = GetHitDice(oAttacker);
    while (iHitDice < (iLevel - 2) )
    {
        iHitDice = LevelUpHenchman(oAttacker);
    }

    DelayCommand(0.5f, AssignCommand(oAttacker, ActionMoveToObject(oWayPoint, TRUE, 2.0f)));
    DelayCommand(1.0f, AssignCommand(oAttacker, DetermineCombatRound()));
}
