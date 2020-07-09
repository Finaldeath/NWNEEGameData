// this is the cutscene where the orcs run thru the fields at night

#include "hf_in_cutscene"
#include "hf_in_graphics"
#include "hf_in_npc"
#include "hf_in_util"

// remove wandering NPCs in cutscene area
void ClearCutsceneArea(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR1500_CUT1_DETOUR");
    object oTrigger = GetObjectByTag("TR_AR1500_CUT1");
    object oInTrigger = GetFirstInPersistentObject(oTrigger, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oInTrigger))
    {
        if ((!GetIsPC(oInTrigger)) && (!GetFactionEqual(oInTrigger, oPC)))
        {
            SetCommandable(TRUE, oInTrigger);
            AssignCommand(oInTrigger, ClearAllActions(TRUE));
            AssignCommand(oInTrigger, ActionJumpToObject(oWP, FALSE));
        }
        oInTrigger = GetNextInPersistentObject(oTrigger, OBJECT_TYPE_CREATURE);
    }
}

// spawn a horde of orcs at a series of waypoints
void HordeSpawn(object oPC)
{
    if (GetLocalInt(GetArea(oPC), "nOrcHordeSpawned") == 0)
    {
        SetLocalInt(GetArea(oPC), "nOrcHordeSpawned", 1);

        object oWP = GetWaypointByTag("WP_AR1500_CUT1_ORCS_0_0");
        object oOrc = CreateObject(OBJECT_TYPE_CREATURE, "ks_farm_tanarukk", GetLocation(oWP), FALSE, "_ar1500_orc_0");

        int i;
        for (i=1; i<=8; i++)
        {
            string sWP = "WP_AR1500_CUT1_ORCS_0_" + IntToString(i);
            object oWP = GetWaypointByTag(sWP);
            string sTag = "ks_farm_orc" + IntToString(d2());
            if(i == 4)
            {
                sTag = "ks_farm_orc3";
            }
            object oOrc = CreateObject(OBJECT_TYPE_CREATURE, sTag, GetLocation(oWP), FALSE, "_ar1500_orc_"+IntToString(i));
        }
    }
}

// move the horde to a specific waypoint series
void HordeMove(object oPC)
{
    int i;
    for (i=0; i<=8; i++)
    {
        object oWP = GetWaypointByTag("WP_AR1500_CUT1_ORCS_1_"+IntToString(i));
        object oOrc = GetObjectByTag("_ar1500_orc_"+IntToString(i));
        AssignCommand(oOrc, ActionMoveToObject(oWP, TRUE));
    }
}

// attack the player
void HordeAttack(object oPC)
{
    int i;
    for (i=0; i<=8; i++)
    {
        object oOrc = GetObjectByTag("_ar1500_orc_"+IntToString(i));
        SetPlotFlag(oOrc, FALSE);
        ChangeToStandardFaction(oOrc, STANDARD_FACTION_HOSTILE);
        AssignCommand(oOrc, ActionAttack(oPC));
    }
}

// stop the orcs from talking and playing sounds
void HordeQuiet(object oPC)
{
    int i;
    for (i=0; i<=8; i++)
    {
        object oOrc = GetObjectByTag("_ar1500_orc_"+IntToString(i));
        SetLocalInt(oOrc, "HF_DISABLE_AM", 1);
    }
}

void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    SetTime(23, 0, 0, 0);
    CutsceneMusic(69, TRUE);
    ClearCutsceneArea(oPC);
    DelayCommand(1.0, CutsceneStart(TRUE, FALSE, "WP_AR1500_CUT1_CAMERA_0"));
    DelayCommand(1.05, CutsceneCameraSetup(-1.0, 90.0, 1.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP));
}

// horde of orcs running towards player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oTanarukk = GetObjectByTag("_ar1500_orc_0");

    if (fTime == 0.0)
    {
        HordeSpawn(oPC);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oTanarukk, PlaySound("c_orc_slct"));
        HordeMove(oPC);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        CutsceneNextShot();
    }
}

// player runs alongside orcs until they reach the skeleton
void next1(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneMoveTo("WP_AR1500_CUT1_CAMERA_1");
        CutsceneCameraSetup(-1.0, 180.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oPC, PlaySound("c_orc_slct"));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oPC, PlaySound("c_orc_atk1"));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, PlaySound("c_orc_atk2"));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        HordeQuiet(oPC);
        CutsceneNextShot();
    }
}

// at destination, orcs bicker about which way to go ... then attack player
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oTanarukk = GetObjectByTag("_ar1500_orc_0");
    object oOrc1 = GetObjectByTag("_ar1500_orc_1");
    object oOrc2 = GetObjectByTag("_ar1500_orc_2");
    object oOrc3 = GetObjectByTag("_ar1500_orc_8");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneMoveTo("WP_AR1500_CUT1_CAMERA_2");
        CutsceneCameraSetup(-1.0, 90.0, 1.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oTanarukk, PlaySound("c_orc_bat2"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"Which way we go now?"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oOrc1, PlaySound("c_orc_slct"));
        AssignCommand(oOrc1, ActionSpeakString(q+"Dat way, boss!"+q));
        AssignCommand(oOrc1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        AssignCommand(oOrc2, PlaySound("c_orc_slct"));
        AssignCommand(oOrc2, ActionSpeakString(q+"No! Dat other way!"+q));
        AssignCommand(oOrc2, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        AssignCommand(oOrc3, PlaySound("c_orc_slct"));
        AssignCommand(oOrc3, ActionSpeakString(q+"Oh no! We lost again!"+q));
        AssignCommand(oOrc3, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        CutsceneNext(25.0);
    }
    else if (fTime == 25.0)
    {
        AssignCommand(oTanarukk, ActionSpeakString(q+"Fools! I'll feed your tongues to the worgs!"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oTanarukk);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oTanarukk, 1000.0);
        DrawCircle(GetLocation(oTanarukk), 2.0, VFX_IMP_FLAME_M);
        CutsceneNext(30.0);
    }
    else if (fTime == 30.0)
    {
        string sSex = "him";
        if (GetGender(oPC) == GENDER_FEMALE)
        {
            sSex = "her";
        }
        AssignCommand(oOrc1, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oOrc1, PlaySound("c_orc_bat2"));
        AssignCommand(oOrc1, ActionSpeakString(q+"Uh, boss? Why don't we asks " + sSex + "?"+q));
        AssignCommand(oOrc1, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(35.0);
    }
    else if (fTime == 35.0)
    {
        CutsceneCameraCloseup(oTanarukk);
        MusicBattlePlay(GetArea(oPC));
        AssignCommand(oTanarukk, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oTanarukk, PlaySound("c_orcchf_bat1"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"A spy! Attack!"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        CutsceneNext(40.0);
    }
    else if (fTime == 40.0)
    {
        CutsceneEnd();
    }
}

void end()
{
    object oPC = GetFirstPC();

    // destroy the placeable object which starts the scene
    object oTrigger = GetObjectInArea("ks_pl_orcsatnight", oPC);
    DestroyObject(oTrigger);

    // horde is spawned and attacks the player
    // the delay gives player a chance to recover from the cutscene
    HordeSpawn(oPC);
    DelayCommand(4.0, HordeAttack(oPC));
    TeleportToWaypoint(oPC, "WP_AR1500_CUT1_CAMERA_2", TRUE);
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
        if (nShot == 2) next2(fTime);
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
