//::///////////////////////////////////////////////
//:: cut_a0_initcmbt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Initiate the combat in the Black Water
    bandits cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"
#include "inc_balance"
#include "nw_i0_generic"

void InitCombat();
void AllyBandit();
void AllyBlood();

void main()
{
    object oPC = GetPCSpeaker();
    object oNisar = GetObjectByTag("A0_TEMP_NISAR");
    object oArea = GetArea(oPC);
    object oRealNisar = GetObjectByTag("a0_hench_nisar");

    object oDoorB = GetObjectByTag("a0_drseige0");
    object oDoor1 = GetObjectByTag("a0_drseige1");
    object oDoor2 = GetObjectByTag("a0_drseige2");
    object oDoor3 = GetObjectByTag("a0_drseige3");
    object oDoor4 = GetObjectByTag("a0_drseige4");

    object oWPDoorB = GetObjectByTag("a0_wpseigeb");
    object oWPDoor1 = GetObjectByTag("a0_wpseigea1");
    object oWPDoor2 = GetObjectByTag("a0_wpseigea2");
    object oWPDoor3 = GetObjectByTag("a0_wpseigea3");
    object oWPDoor4 = GetObjectByTag("a0_wpseigea4");

    // JE: This should be delayed slightly, otherwise we see the start of
    // him fading out.
    //DestroyObject(oNisar);
    cs_DestroyObject(1.5, oNisar, oArea);

    SetLocked(oDoorB, FALSE);
    SetLocked(oDoor1, FALSE);
    SetLocked(oDoor2, FALSE);
    SetLocked(oDoor3, FALSE);
    SetLocked(oDoor4, FALSE);

    SetMapPinEnabled(oWPDoorB, TRUE);
    SetMapPinEnabled(oWPDoor1, TRUE);
    SetMapPinEnabled(oWPDoor2, TRUE);
    SetMapPinEnabled(oWPDoor3, TRUE);
    SetMapPinEnabled(oWPDoor4, TRUE);

    cs_CameraDoFade(0.5f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST, oArea);
    AssignCommand(oArea, InitCombat());

    // JE: Place Nisar in the proper place at the end of the cutscene.
    // I'll make sure Nisar is actually in the area and has a master before
    // doing it.
    if( GetArea(oRealNisar)==GetArea(OBJECT_SELF) &&
        GetIsObjectValid(GetMaster(oRealNisar)))
    {
        object oWP_RealNisar = GetWaypointByTag("wp_brb_nisar");
        DelayCommand(1.0, AssignCommand(oRealNisar, ClearAllActions(TRUE)));
        DelayCommand(1.1, AssignCommand(oRealNisar, ActionJumpToObject(oWP_RealNisar)));
    }

    // JE: Destroy PC copies early to avoid seeing them fade out.
    cs_DestroyObject(1.2, GetObjectByTagInArea("PCTalker", oArea), oArea);
    cs_DestroyObject(1.2, GetObjectByTagInArea("PCClone1", oArea), oArea);
    cs_DestroyObject(1.2, GetObjectByTagInArea("PCClone2", oArea), oArea);
    cs_DestroyObject(1.2, GetObjectByTagInArea("PCClone3", oArea), oArea);
    cs_EndCutscene(2.5f, FALSE, TRUE, FADE_SPEED_FAST, 1, oArea);
}

void InitCombat()
{
    object oBRBFaction = GetObjectByTag("a0_spwnbnd");
    object oBLDFaction = GetObjectByTag("a0_spwnbld");

    object oBRBandit1 = GetObjectByTag("a0_bradleyblkr");
    object oBRBandit2 = GetObjectByTag("a0_honeypea");

    object oSailor1 = GetObjectByTag("a0_bloodcut1");
    object oSailor2 = GetObjectByTag("a0_bloodcut2");
    object oSailor3 = GetObjectByTag("a0_bloodcut3");
    object oSailor4 = GetObjectByTag("a0_bloodcut4");

    object oCursor = OBJECT_INVALID;

    int iBloodS = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");
    int iBandit = GetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY");
    int iCounter, iDifficulty;

    AdjustReputation(oBRBFaction, oBLDFaction, -100);
    AdjustReputation(oBLDFaction, oBRBFaction, -100);
    AdjustReputation(oBRBandit1, oSailor1, -100);
    AdjustReputation(oSailor1, oBRBandit1, -100);

    if(iBloodS == TRUE)
    {
        AllyBlood();
    }
    else if (iBandit == TRUE)
    {
        AllyBandit();
    }

    //Clear the ambient Bloodsailors
    iCounter = 0;
    oCursor = GetObjectByTag("a0_bloodsailor", iCounter++);
    while (oCursor != OBJECT_INVALID)
    {
        DestroyObject(oCursor, 1.0f);
        oCursor = GetObjectByTag("a0_bloodsailor", iCounter++);
    }

    //Clear the ambient Bandits
    iCounter = 0;
    oCursor = GetObjectByTag("a0_br_bandit", iCounter++);
    while (oCursor != OBJECT_INVALID)
    {
        DestroyObject(oCursor, 1.0f);
        oCursor = GetObjectByTag("a0_br_bandit", iCounter++);
    }

    // modified as of bug 1065 work roll.
    // Complaints of too many hostiles spawning in.
    iDifficulty = GetGameDifficulty();
    switch (iDifficulty)
    {
        // four for each side in Difficult
        case GAME_DIFFICULTY_CORE_RULES:
        case GAME_DIFFICULTY_DIFFICULT:
            SetLocalString(oBLDFaction, "sResRef1", "a0_bloodrespm");
            SetLocalString(oBLDFaction, "sResRef2", "a0_bloodrespf");
            SetLocalString(oBLDFaction, "sResRef3", "a0_bloodrespm");
            SetLocalString(oBLDFaction, "sResRef4", "a0_bloodrespf");
            SetLocalInt(oBLDFaction, "iBLDCounter", 4);

            SetLocalString(oBRBFaction, "sResRef1", "a0brbandit002");
            SetLocalString(oBRBFaction, "sResRef2", "a0brbandit001");
            SetLocalString(oBRBFaction, "sResRef3", "a0brbandit002");
            SetLocalString(oBRBFaction, "sResRef4", "a0brbandit001");
            SetLocalInt(oBRBFaction, "iBNDCounter", 4);
        break;

        // Three for normal
        case GAME_DIFFICULTY_NORMAL:
            SetLocalString(oBLDFaction, "sResRef1", "a0_bloodrespm");
            SetLocalString(oBLDFaction, "sResRef2", "a0_bloodrespf");
            SetLocalString(oBLDFaction, "sResRef3", "a0_bloodrespm");
            SetLocalInt(oBLDFaction, "iBLDCounter", 3);

            SetLocalString(oBRBFaction, "sResRef1", "a0brbandit002");
            SetLocalString(oBRBFaction, "sResRef2", "a0brbandit001");
            SetLocalString(oBRBFaction, "sResRef3", "a0brbandit002");
            SetLocalInt(oBRBFaction, "iBNDCounter", 3);
        break;

        // Two for easy or very easy
        default:
            SetLocalString(oBLDFaction, "sResRef1", "a0_bloodrespm");
            SetLocalString(oBLDFaction, "sResRef2", "a0_bloodrespf");
            SetLocalInt(oBLDFaction, "iBLDCounter", 2);

            SetLocalString(oBRBFaction, "sResRef1", "a0brbandit002");
            SetLocalString(oBRBFaction, "sResRef2", "a0brbandit001");
            SetLocalInt(oBRBFaction, "iBNDCounter", 2);
        break;
    }

    DelayCommand(3.0f, AssignCommand(oSailor1, DetermineCombatRound(oBRBandit1)));
    DelayCommand(3.0f, AssignCommand(oSailor2, DetermineCombatRound(oBRBandit2)));
    DelayCommand(3.0f, AssignCommand(oSailor3, DetermineCombatRound(oBRBandit1)));
    DelayCommand(3.0f, AssignCommand(oSailor4, DetermineCombatRound(oBRBandit2)));

    DelayCommand(3.0f, AssignCommand(oBRBandit1, DetermineCombatRound(oSailor1)));
    DelayCommand(3.0f, AssignCommand(oBRBandit2, DetermineCombatRound(oSailor2)));
}

void AllyBandit()
{
    object oArea = OBJECT_SELF;
    object oCursor = GetFirstPC();
    object oNisar = GetObjectByTag("a0_hench_nisar");

    object oBRBBradley = GetObjectByTag("a0_bradleyblkr");
    object oBRBHoney = GetObjectByTag("a0_honeypea");
    object oSailor1 = GetObjectByTag("a0_bloodcut1");

    object oBRBFaction = GetObjectByTag("a0_spwnbnd");
    object oBLDFaction = GetObjectByTag("a0_spwnbld");

    SetImmortal(oBRBBradley, TRUE);
    SetImmortal(oBRBHoney, TRUE);

    AdjustReputation(oNisar, oBRBFaction, 100);
    AdjustReputation(oNisar, oBLDFaction, -100);
    DelayCommand(0.5f, AdjustReputation(oNisar, oBRBBradley, 100));
    DelayCommand(0.5f, AdjustReputation(oNisar, oSailor1, -100));

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        AdjustReputation(oCursor, oBRBFaction, 100);
        AdjustReputation(oCursor, oBLDFaction, -100);
        DelayCommand(0.5f, AdjustReputation(oCursor, oBRBBradley, 100));
        DelayCommand(0.5f, AdjustReputation(oCursor, oSailor1, -100));

        oCursor = GetNextPC();
    }
}

void AllyBlood()
{
    object oArea = OBJECT_SELF;
    object oCursor = GetFirstPC();
    object oNisar = GetObjectByTag("a0_hench_nisar");

    object oBRBBradley = GetObjectByTag("a0_bradleyblkr");
    object oSailor1 = GetObjectByTag("a0_bloodcut1");

    object oBRBFaction = GetObjectByTag("a0_spwnbnd");
    object oBLDFaction = GetObjectByTag("a0_spwnbld");

    AdjustReputation(oNisar, oBLDFaction, 100);
    AdjustReputation(oNisar, oBRBFaction, -100);
    DelayCommand(0.5f, AdjustReputation(oNisar, oSailor1, 100));
    DelayCommand(0.5f, AdjustReputation(oNisar, oBRBBradley, -100));

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        AdjustReputation(oCursor, oBLDFaction, 100);
        AdjustReputation(oCursor, oBRBFaction, -100);
        DelayCommand(0.5f, AdjustReputation(oCursor, oSailor1, 100));
        DelayCommand(0.5f, AdjustReputation(oCursor, oBRBBradley, -100));

        oCursor = GetNextPC();
    }
}

