// this is the cutscene where zhents attack astriel and player in chateau elite

#include "nw_i0_generic"
#include "hf_in_cutscene"

const float fCameraHeight = 3.0;

// make sure the door is closed and ready to be bashed open by the zhents
void CloseDoor(object oPC)
{
    object oDoor = GetObjectByTag("astrielsdoor");
    SetPlotFlag(oDoor, FALSE);
    AssignCommand(oDoor, ActionCloseDoor(oDoor));
    object oWP = GetWaypointByTag("WP_AR0101_CUT1_DOOR");
    vector v = GetPosition(oWP);
    v.z += 1.5;
    location lDoor = Location(GetArea(oWP), v, 0.0);
    object oVoice = CreateObject(OBJECT_TYPE_PLACEABLE, "pm_voice", lDoor, FALSE, "_voice");
    CutsceneAddActor("_voice", oVoice);
    object oDoor2 = GetObjectByTag("dt_ar0101_rooms");
    AssignCommand(oDoor2, ActionCloseDoor(oDoor2));
    SetLocked(oDoor2, TRUE);
}

// move the maid to safety and disable her AI
void MoveMaid(object oPC)
{
    object oMaid = GetObjectByTag("ac_inn_maid");
    if (GetIsObjectValid(oMaid))
    {
        object oWP = GetObjectByTag("pm_cs_maid_jump");
        AssignCommand(oMaid, ClearAllActions(TRUE));
        AssignCommand(oMaid, ActionJumpToObject(oWP, FALSE));
        SetLocalInt(oMaid, "no_banter", 1);
    }
}

// spawn some zhents outside the door
void SpawnZhents(object oPC)
{
    int i = 1;
    object oZhent = GetObjectByTag("_zhent_ar0101");
    if (!GetIsObjectValid(oZhent))
    {
        string sWP = "WP_AR0101_CUT1_ZHENTS_" + IntToString(i);
        object oWP = GetWaypointByTag(sWP);
        location lZhent1 = GetLocation(oWP);
        object oZhent1 = CreateObject(OBJECT_TYPE_CREATURE, "rb_zhentagent_fg", lZhent1, FALSE, "_zhent_ar0101");
        i++;
        sWP = "WP_AR0101_CUT1_ZHENTS_" + IntToString(i);
        oWP = GetWaypointByTag(sWP);
        lZhent1 = GetLocation(oWP);
        object oZhent2 = CreateObject(OBJECT_TYPE_CREATURE, "rb_zhentagent_fg", lZhent1, FALSE, "_zhent_ar0101");
        i++;
        sWP = "WP_AR0101_CUT1_ZHENTS_" + IntToString(i);
        oWP = GetWaypointByTag(sWP);
        lZhent1 = GetLocation(oWP);
        object oZhent3 = CreateObject(OBJECT_TYPE_CREATURE, "rb_zhentagent_w2", lZhent1, FALSE, "_zhent_ar0101");
    }
}

// start the scene, clear the area, and make sure the door is closed
void start()
{
    object oPC = GetFirstPC();
    FadeToBlack(oPC, FADE_SPEED_FASTEST);
    CutsceneStart(FALSE, FALSE);
    CloseDoor(oPC);
    MoveMaid(oPC);
    CutsceneMusic(8);
}

// player and astriel see the door get bashed open by some zhents
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oAstriel = GetObjectByTag("pm_astriel2");
    object oVoice = CutsceneGetActor("_voice");
    object oDoor = GetObjectByTag("astrielsdoor");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(0.5);
    }
    else if (fTime == 0.5)
    {
        // astriel and player move into position
        object oWP1 = GetWaypointByTag("WP_AR0101_CUT1_ASTRIEL");
        AssignCommand(oAstriel, ClearAllActions());
        AssignCommand(oAstriel, ActionMoveToObject(oWP1, TRUE, 0.0));
        object oWP2 = GetWaypointByTag("WP_AR0101_CUT1_START");
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionMoveToObject(oWP2, FALSE, 0.0));
        CutsceneNext(1.7);
    }
    else if (fTime == 1.7)
    {
        // player and astriel turn to face each other
        AssignCommand(oAstriel, ClearAllActions());
        AssignCommand(oAstriel, ActionDoCommand(SetFacingPoint(GetPosition(oPC))));
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionDoCommand(SetFacingPoint(GetPosition(oAstriel))));
        CutsceneNext(1.75);
    }
    else if (fTime == 1.75)
    {
        // camera focus on astriel
        FadeFromBlack(oPC);
        CutsceneCameraSetup(fCameraHeight, 300.0, 7.0, 55.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // astriel hears something outside
        AssignCommand(oAstriel, PlaySound("vs_astriel_083"));
        AssignCommand(oAstriel, ActionSpeakString(q+"Listen! Someone is at the door!"+q));
        AssignCommand(oAstriel, ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 2.0));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // footsteps
        AssignCommand(oAstriel, PlaySound("fs_carpt_hard1"));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // footsteps
        AssignCommand(oAstriel, PlaySound("fs_carpt_hard2"));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // footsteps
        AssignCommand(oAstriel, PlaySound("fs_carpt_hard3"));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        // footsteps
        AssignCommand(oAstriel, PlaySound("fs_carpt_hard1"));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // focus on door
        CutsceneCameraSetup(fCameraHeight, 160.0, 9.0, 55.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        // knocking at the door
        AssignCommand(oVoice, PlaySound("as_dr_locked2"));
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        // a voice at the door
        AssignCommand(oVoice, PlaySound("vs_mkiller1_001"));
        AssignCommand(oVoice, ActionSpeakString(q+"I have the oils and perfumes that you ordered, my Lady."+q));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        AssignCommand(oAstriel, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        // camera focus on Astriel
        CutsceneCameraSetup(fCameraHeight, 300.0, 7.0, 55.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(21.0);
    }
    else if (fTime == 21.0)
    {
        // astriel curses the player
        AssignCommand(oAstriel, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oAstriel, PlaySound("vs_astriel_084"));
        AssignCommand(oAstriel, ActionSpeakString(q+"I did not order any oils! You were followed!"+q));
        AssignCommand(oAstriel, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0));
        MusicBattlePlay(GetArea(oPC));
        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        // camera focus on door
        CutsceneCameraSetup(fCameraHeight, 160.0, 9.0, 55.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oPC, SetFacingPoint(GetPosition(oDoor)));
        AssignCommand(oAstriel, SetFacingPoint(GetPosition(oDoor)));
        SpawnZhents(oPC);
        CutsceneNext(29.0);
    }
    else if (fTime == 29.0)
    {
        CutsceneNextShot();
    }
}

// zhents bust open the door and attack
void next1(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        // zhents bust open the door
        object oDoor = GetObjectByTag("astrielsdoor");
        effect eDamage = EffectDamage(400, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oDoor);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // zhents attack
        int i = 0;
        object oZhent = GetObjectByTag("_zhent_ar0101", i);
        object oDest  = GetWaypointByTag("MOVE_zhent_ar0101");
        location lDest = GetLocation(oDest);
        while (GetIsObjectValid(oZhent))
        {
            AssignCommand(oZhent, ActionMoveToLocation(lDest, TRUE));
            oZhent = GetObjectByTag("_zhent_ar0101", ++i);
        }
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        CutsceneEnd();
    }
}

// post-conditions: door is destroyed, zhents are spawned
void end()
{
    object oPC = GetFirstPC();

    // remove the henchman copies
    object oHench1Copy = CutsceneGetActor("_ar0101_hench1");
    if (GetIsObjectValid(oHench1Copy))
    {
        AssignCommand(oHench1Copy, ClearAllActions(TRUE));
        AssignCommand(oHench1Copy, SetIsDestroyable(TRUE));
        DestroyObject(oHench1Copy);
        DestroyObject(oHench1Copy, 0.5);
        DestroyObject(oHench1Copy, 1.0);
    }
    object oHench2Copy = CutsceneGetActor("_ar0101_hench2");
    if (GetIsObjectValid(oHench2Copy))
    {
        AssignCommand(oHench2Copy, ClearAllActions(TRUE));
        AssignCommand(oHench2Copy, SetIsDestroyable(TRUE));
        DestroyObject(oHench2Copy);
        DestroyObject(oHench2Copy, 0.5);
        DestroyObject(oHench2Copy, 1.0);
    }

    // make sure the zhents are spawned
    SpawnZhents(oPC);
    int i = 0;
    object oZhent = GetObjectByTag("_zhent_ar0101", i);
    while (GetIsObjectValid(oZhent))
    {
        DelayCommand(0.25, ChangeToStandardFaction(oZhent, STANDARD_FACTION_HOSTILE));
        DelayCommand(0.5, AssignCommand(oZhent, DetermineCombatRound(oPC)));
        oZhent = GetObjectByTag("_zhent_ar0101", ++i);
    }

    // destroy the door and the voice
    object oVoice = CutsceneGetActor("_voice");
    object oDoor = GetObjectByTag("astrielsdoor");
    effect eDamage = EffectDamage(400, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oDoor);
    //DestroyObject(oDoor); -- this left space beyond in darkness
    DestroyObject(oVoice);

    int h = 1;
    object oHench = GetHenchman(oPC, h);

    while(oHench != OBJECT_INVALID)
    {
        DelayCommand(0.5, AssignCommand(oHench, DetermineCombatRound(GetObjectByTag("_zhent_ar0101"))));
        h++;
        oHench = GetHenchman(oPC, h);
    }

    // make sure that astriel doesn't run off to her exit too soon
    object oAstriel = GetObjectByTag("pm_astriel2");
    SetLocalInt(oAstriel, "NW_GENERIC_MASTER", 0);
    DelayCommand(0.5, AssignCommand(oAstriel, DetermineCombatRound(GetObjectByTag("_zhent_ar0101"))));

    // restore sound again and flag that we are all done
    object oArea = GetArea(oPC);
    SetLocalInt(oArea, "Cutscene_Fired", 1);
    SetLocalInt(GetModule(), "nAmaraHasLeftElite", 1);
    AssignCommand(oPC, SetCameraFacing(90.0, 15.0));
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
