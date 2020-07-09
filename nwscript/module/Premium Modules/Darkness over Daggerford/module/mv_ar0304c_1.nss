// this is the cutscene in black stone inn sewers where zhents are talking

#include "hf_in_cutscene"
#include "hf_in_spawn"
#include "nw_i0_generic"
#include "hf_in_npc"

// spawn the scene actors
void spawnActors(object oPC)
{
    object oWP;

    // wizard
    oWP = GetWaypointByTag("WP_AR0304C_CUT1_ZHENT1");
    object oWizard = CreateObject(OBJECT_TYPE_CREATURE, "pm_zhentagent_wz", GetLocation(oWP));
    ChangeToStandardFaction(oWizard, STANDARD_FACTION_COMMONER);
    CutsceneAddActor("zhent1", oWizard);

    // fighter
    oWP = GetWaypointByTag("WP_AR0304C_CUT1_ZHENT2");
    object oFighter1 = CreateObject(OBJECT_TYPE_CREATURE, "pm_zhentagent_fg", GetLocation(oWP));
    ChangeToStandardFaction(oFighter1, STANDARD_FACTION_COMMONER);
    CutsceneAddActor("zhent2", oFighter1);

    // fighter
    oWP = GetWaypointByTag("WP_AR0304C_CUT1_ZHENT3");
    object oFighter2 = CreateObject(OBJECT_TYPE_CREATURE, "pm_zhentagent_fg", GetLocation(oWP));
    ChangeToStandardFaction(oFighter2, STANDARD_FACTION_COMMONER);
    CutsceneAddActor("zhent3", oFighter2);

    // rogue
    oWP = GetWaypointByTag("WP_AR0304C_CUT1_ZHENT4");
    object oRogue1 = CreateObject(OBJECT_TYPE_CREATURE, "pm_zhentagent_rg", GetLocation(oWP));
    ChangeToStandardFaction(oRogue1, STANDARD_FACTION_COMMONER);
    CutsceneAddActor("zhent4", oRogue1);

    // rogue
    oWP = GetWaypointByTag("WP_AR0304C_CUT1_ZHENT5");
    object oRogue2 = CreateObject(OBJECT_TYPE_CREATURE, "pm_zhentagent_rg", GetLocation(oWP));
    ChangeToStandardFaction(oRogue2, STANDARD_FACTION_COMMONER);
    CutsceneAddActor("zhent5", oRogue2);

    // weak mage
    oWP = GetWaypointByTag("WP_AR0304C_CUT1_ZHENT6");
    object oMage1 = CreateObject(OBJECT_TYPE_CREATURE, "pm_zhentagent_mg", GetLocation(oWP));
    ChangeToStandardFaction(oMage1, STANDARD_FACTION_COMMONER);
    CutsceneAddActor("zhent6", oMage1);

    // weak mage
    oWP = GetWaypointByTag("WP_AR0304C_CUT1_ZHENT7");
    object oMage2 = CreateObject(OBJECT_TYPE_CREATURE, "pm_zhentagent_mg", GetLocation(oWP));
    ChangeToStandardFaction(oMage2, STANDARD_FACTION_COMMONER);
    CutsceneAddActor("zhent7", oMage2);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    spawnActors(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR0304C_CUT1_START", FALSE);
    CutsceneMusic(68);
}

// zhents are talking
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oZhent1 = CutsceneGetActor("zhent1");
    object oZhent2 = CutsceneGetActor("zhent2");
    object oZhent3 = CutsceneGetActor("zhent3");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // allow some time for spawn and camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, 170.0, 7.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 1.0, 82.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oZhent1, PlaySound("vs_nfanatm1_haha"));
        AssignCommand(oZhent1, ActionSpeakString(q+"Ha! It's only a matter of time before we crush Daggerford!"+q));
        AssignCommand(oZhent1, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        AssignCommand(oZhent1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 9.0));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        AssignCommand(oZhent2, PlaySound("vs_nlusgrm1_haha"));
        AssignCommand(oZhent2, ActionSpeakString(q+"These fools have no idea what's in store for 'em!"+q));
        AssignCommand(oZhent2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 8.0));
        AssignCommand(oZhent2, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        AssignCommand(oZhent3, PlaySound("as_pl_hiccupm1"));
        AssignCommand(oZhent3, ActionSpeakString(q+"Ha! That Bugo is a character, ain't he?"+q));
        AssignCommand(oZhent3, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oZhent3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 5.0));
        CutsceneNext(29.0);
    }
    else if (fTime == 29.0)
    {
        CutsceneNextShot();
    }
}

// zhents notice player and attack
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oZhent1 = CutsceneGetActor("zhent1");
    object oZhent2 = CutsceneGetActor("zhent2");
    object oZhent3 = CutsceneGetActor("zhent3");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        AssignCommand(oZhent1, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oZhent1, ActionSpeakString(q+"Ah, Teshlang, you're late again! We were...hey! Who are you?"+q));
        AssignCommand(oZhent1, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        AssignCommand(oZhent1, ActionWait(2.0));
        AssignCommand(oZhent1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oZhent2, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oZhent2, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oZhent3, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oZhent3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 1.0));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        MusicBattlePlay(GetArea(oPC));
        AssignCommand(oZhent1, PlaySound("vs_nfanatm1_bat2"));
        AssignCommand(oZhent2, ActionSpeakString(q+"Get 'em!"+q));
        AssignCommand(oZhent2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0));
        AssignCommand(oZhent1, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        AssignCommand(oZhent3, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        CutsceneEnd();
    }
}

// cause an NPC to attack the PC
void GoHostile(object oNPC, object oPC)
{
    ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
    AssignCommand(oNPC, ActionAttack(oPC));
    AssignCommand(oNPC, DetermineCombatRound(oPC));
}

// the zhents attack the player
void end()
{
    object oPC = GetFirstPC();
    object oZhent1 = CutsceneGetActor("zhent1");
    object oZhent2 = CutsceneGetActor("zhent2");
    object oZhent3 = CutsceneGetActor("zhent3");
    object oZhent4 = CutsceneGetActor("zhent4");
    object oZhent5 = CutsceneGetActor("zhent5");
    object oZhent6 = CutsceneGetActor("zhent6");
    object oZhent7 = CutsceneGetActor("zhent7");

    // the zhents attack the player
    MusicBattlePlay(GetArea(oPC));

    DelayCommand(1.5, GoHostile(oZhent1, oPC));
    DelayCommand(1.5, GoHostile(oZhent2, oPC));
    DelayCommand(1.5, GoHostile(oZhent3, oPC));
    DelayCommand(1.5, GoHostile(oZhent4, oPC));
    DelayCommand(1.5, GoHostile(oZhent5, oPC));
    DelayCommand(1.5, GoHostile(oZhent6, oPC));
    DelayCommand(1.5, GoHostile(oZhent7, oPC));

    // move the player into the room
    TeleportToWaypoint(oPC, "WP_AR0304C_CUT1_END", FALSE);
}

void main()
{
    int nShot = CutsceneGetShot();
    float fTime = CutsceneGetTime();
    int nEvent = CutsceneGetEvent();

    if (nEvent == CUTSCENE_EVENT_START)
    {
        start();
        CutsceneNext(0.0);
    }
    else if (nEvent == CUTSCENE_EVENT_SHOT ||
             nEvent == CUTSCENE_EVENT_NEXT)
    {
        if (nShot == 0) next0(fTime);
        if (nShot == 1) next1(fTime);
   }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
