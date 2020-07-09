//::///////////////////////////////////////////////
//:: pus_a3_sigil
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A PC has tried to use the sigil.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

const string S_NO_PARTY = "You need to gather your crew before activating this sigil.";
const string S_NO_KEY = "You cannot activate this sigil without the Activator device.";

void ActionDoEffects(object oSigil);
void SummonMonster(location lTarg, string sMonster);

void main()
{
    object oSigil = OBJECT_SELF;
    object oPC = GetLastUsedBy();
    object oWayPoint = GetNearestObjectByTag("A3_POSITION", oSigil, 0);
    object oTom = GetObjectByTag("a3_oldtom_a");
    object oKey = GetItemPossessedBy(oPC, "a3_sigilkey");
    object oNPC;

    effect eGhost = EffectCutsceneGhost();
    int iSpark = GetLocalInt(GetModule(), "A3_SPARKLE") + 1;
    location lWaypoint = GetLocation(oWayPoint);

    string sNPCTag = GetLocalString(GetModule(), "NPC_CREW" + IntToString(iSpark));

    int iActivated = GetLocalInt(oSigil, "ACTIVATED");
    int iFollow =  GetLocalInt(GetModule(), "A3_HUNT");

    // If the plot is not yet active block the PC
    if ((GetIsPC(oPC) == TRUE) && (iFollow < 10))
    {
        FloatingTextStringOnCreature(S_NO_PARTY, oPC);
    }
    // If the PC doesn't have the key block them
    else if ((GetIsPC(oPC) == TRUE) && (GetIsObjectValid(oKey) == FALSE))
    {
        FloatingTextStringOnCreature(S_NO_KEY, oPC);
    }
    else if ((GetIsPC(oPC) == TRUE) && (iActivated == FALSE))
    {
        oNPC = GetObjectByTag(sNPCTag);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oNPC);

        SetPlotFlag(oNPC, TRUE);
        SetLocalInt(oNPC, "NO_TALKIE", TRUE);

        AssignCommand(oNPC, SurrenderToEnemies());
        ChangeToStandardFaction(oNPC, STANDARD_FACTION_COMMONER);

        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, SpeakOneLinerConversation("a3_station"));
        AssignCommand(oNPC, ActionForceMoveToLocation(lWaypoint, TRUE, 5.0f));
        AssignCommand(oNPC, ActionDoCommand(ActionDoEffects(oSigil)));
    }
}

void ActionDoEffects(object oSigil)
{
    object oWayPoint = GetNearestObjectByTag("A3_POSITION", oSigil, 0);
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSigil);

    location lTarg = GetLocation(oWayPoint);
    string sMonster = GetLocalString(oSigil, "MONS_RESREF");

    effect eSolve = EffectVisualEffect(VFX_FNF_WORD);
    effect eGhost = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);

    ExecuteScript("exe_a3_huntinc", oPC);

    SetLocalInt(oSigil, "ACTIVATED", TRUE);

    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_a3_feild", lTarg);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSolve, lTarg);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);

    SetLocalInt(OBJECT_SELF, "STATIONED", TRUE);
    SetLocalInt(OBJECT_SELF, "NO_TALKIE", FALSE);

    //DelayCommand(1.0f, SummonMonster(lTarg, sMonster));
}

void SummonMonster(location lTarg, string sMonster)
{
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lTarg);
    CreateObject(OBJECT_TYPE_CREATURE, sMonster, lTarg);
}
