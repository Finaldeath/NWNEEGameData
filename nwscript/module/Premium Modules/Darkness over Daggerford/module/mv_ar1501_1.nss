// this is the cutscene in the goblin kitchens where the golbin king
// .. is butchering some cows. A Tanarukk arrives and fights the player.

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_util"

object GetNearestCreatureByTag(string sTag, object oPC, int n=1)
{
    int i = n;
    object oNPC = OBJECT_INVALID;
    oNPC = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(oNPC))
    {
        if (GetObjectType(oNPC) == OBJECT_TYPE_CREATURE)
        {
            break;
        }
        oNPC = GetObjectInArea(sTag, oPC, ++i);
    }
    return(oNPC);
}

string GetRaceName(object oPC)
{
    int nType = GetRacialType(oPC);
    if (nType == RACIAL_TYPE_DWARF) return ("Dwarf");
    if (nType == RACIAL_TYPE_ELF) return ("Elf");
    if (nType == RACIAL_TYPE_GNOME) return ("Gnome");
    if (nType == RACIAL_TYPE_HALFELF) return ("Half Elf");
    if (nType == RACIAL_TYPE_HALFLING) return ("Halfling");
    if (nType == RACIAL_TYPE_HALFORC) return ("Half Orc");
    if (nType == RACIAL_TYPE_HUMAN) return ("Human");
    return ("spy");
}

void GoblinsFlee(object oPC)
{
    if (GetLocalInt(GetArea(oPC), "nCutsceneGoblinsFlee") == 0)
    {
        SetLocalInt(GetArea(oPC), "nCutsceneGoblinsFlee", 1);

        int i = 1;
        object oGoblin = GetNearestCreatureByTag("db_flee_goblin", oPC, i);
        while (GetIsObjectValid(oGoblin))
        {
            float fDist = GetDistanceBetween(oPC, oGoblin);
            if (fDist >= 0.0 && fDist <= 40.0)
            {
                SignalEvent(oGoblin, EventUserDefined(999));
            }
            oGoblin = GetNearestCreatureByTag("db_flee_goblin", oPC, ++i);
        }
    }
}

void spawnNPCs(object oPC)
{
    object oWP;

    oWP = GetWaypointByTag("WP_AR1501_CUT1_BUTCHER");
    object oButcher = CreateObject(OBJECT_TYPE_CREATURE, "db_thebutcher", GetLocation(oWP));
    CutsceneAddActor("db_thebutcher", oButcher);

    oWP = GetWaypointByTag("WP_AR1501_CUT1_SHAMAN");
    object oShaman = CreateObject(OBJECT_TYPE_CREATURE, "db_goblinshaman", GetLocation(oWP));
    CutsceneAddActor("db_goblinshaman", oShaman);

    oWP = GetWaypointByTag("WP_AR1501_CUT1_TANARUKK");
    object oTanarukk = CreateObject(OBJECT_TYPE_CREATURE, "db_tanarukk02", GetLocation(oWP));
    CutsceneAddActor("db_tanarukk02", oTanarukk);
}

void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(TRUE, FALSE, "WP_AR1501_CUT1_START", FALSE);
    CutsceneCameraSetup(-1.0, DIRECTION_WEST, 1.5, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
    spawnNPCs(oPC);
}

void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oTanarukk = CutsceneGetActor("db_tanarukk02");
    object oButcher = CutsceneGetActor("db_thebutcher");

    if (fTime == 0.0)
    {
        // delay to allow spawns to occur
        FadeFromBlack(oPC, FADE_SPEED_SLOW);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oButcher, ClearAllActions());
        AssignCommand(oButcher, PlaySound("vs_ngobkngm_haha"));
        AssignCommand(oButcher, ActionSpeakString("Mmm ... cows ... Tasty!"));
        AssignCommand(oButcher, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        object oWP = GetObjectByTag("WP_AR1501_CUT1_TANARUKK_CLOSEUP");
        AssignCommand(oTanarukk, ClearAllActions());
        AssignCommand(oTanarukk, ActionMoveToObject(oWP, TRUE, 0.0));
        AssignCommand(oTanarukk, ActionDoCommand(SetFacingPoint(GetPosition(oButcher))));
        AssignCommand(oTanarukk, ActionDoCommand(CutsceneNextShot()));
    }
}

void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oTanarukk = CutsceneGetActor("db_tanarukk02");
    object oButcher = CutsceneGetActor("db_thebutcher");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        AssignCommand(oTanarukk, ClearAllActions());
        AssignCommand(oTanarukk, PlaySound("c_orc_bat2"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"You! Goblin! You steal cows! That not our deal!"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oButcher, ClearAllActions());
        AssignCommand(oButcher, SetFacingPoint(GetPosition(oTanarukk)));
        AssignCommand(oButcher, PlaySound("vs_ngobkngm_hit2"));
        AssignCommand(oButcher, ActionSpeakString(q+"Uh oh!"+q));
        AssignCommand(oButcher, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oButcher, PlaySound("c_goblin_hit2"));
        AssignCommand(oButcher, ActionSpeakString(q+"Uh...cows? What cows? No cows here!"+q));
        AssignCommand(oButcher, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oButcher, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        AssignCommand(oButcher, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        AssignCommand(oTanarukk, PlaySound("c_orc_atk2"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"Argh! You standing on dead cow!"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        AssignCommand(oButcher, PlaySound("c_goblin_slct"));
        AssignCommand(oButcher, ActionSpeakString(q+"Uh... That just...uh...cow-shaped rock!"+q));
        AssignCommand(oButcher, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(25.0);
    }
    else if (fTime == 25.0)
    {
        CutsceneNextShot();
    }
}

void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oTanarukk = CutsceneGetActor("db_tanarukk02");
    object oButcher = CutsceneGetActor("db_thebutcher");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        object oPot = GetObjectInArea("x0_cauldron", oPC);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), GetLocation(oPot));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oTanarukk);
        AssignCommand(oTanarukk, PlaySound("c_orc_bat1"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"Fool! I'll rip out your --"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oButcher, PlaySound("c_goblin_hit2"));
        AssignCommand(oButcher, ActionSpeakString(q+"No! Me too young to die!"+q));
        AssignCommand(oButcher, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 3.0));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oTanarukk, PlaySound("c_orc_atk1"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"*Sniff* What's that smell? *Sniff*"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        AssignCommand(oButcher,  ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        AssignCommand(oButcher, PlaySound("c_goblin_slct"));
        AssignCommand(oButcher, ActionSpeakString(q+"Uh...maybe you forget bath today?"+q));
        AssignCommand(oButcher, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 6.0, 70.0, CAMERA_TRANSITION_TYPE_FAST);
        AssignCommand(oTanarukk, PlaySound("c_orc_bat2"));
        AssignCommand(oTanarukk, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oTanarukk, ActionSpeakString(q+"I smell a filthy " + GetRaceName(oPC) + "!"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR));
        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        GoblinsFlee(oPC);
        CutsceneNext(26.0);
    }
    else if (fTime == 26.0)
    {
        object oWP = GetWaypointByTag("WP_AR1501_CUT1_TANARUKK_CLOSEUP");
        AssignCommand(oTanarukk, ActionMoveToObject(oWP, TRUE, 0.0));
        AssignCommand(oTanarukk, ActionDoCommand(SetFacing(0.0)));
        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        MusicBattlePlay(GetArea(oPC));
        CutsceneMoveTo("WP_AR1501_CUT1_CLOSEUP");
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 1.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oTanarukk, PlaySound("c_orcchf_bat1"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"Spy! Your rotting carcass shall hang among these cows!"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(35.0);
    }
    else if (fTime == 35.0)
    {
        // fade the screen to hide the move in the next time interval
        FadeToBlack(oPC, FADE_SPEED_FAST);
        CutsceneNext(36.0);
    }
    else if (fTime == 36.0)
    {
        // move player into the area to avoid enemies bunching up at the
        // .. doors in the resulting combat
        object oWP = GetNearestObjectByTag("WP_AR1501_CUT1_END", oPC);
        AssignCommand(oPC, ActionJumpToObject(oWP, FALSE));
        CutsceneNext(37.0);
    }
    else if (fTime == 37.0)
    {
        CutsceneEnd();
    }
}

// the delay here just gives the PC a chance to teleport away
// from the cutscene before being attacked by the bad guys
void AttackPC(string sTag, object oPC)
{
    int i = 1;
    object oNPC = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(oNPC))
    {
        if (GetObjectType(oNPC) == OBJECT_TYPE_CREATURE)
        {
            SetPlotFlag(oNPC, FALSE);
            ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
            if (GetDistanceBetween(oPC, oNPC) > 20.0)
            {
                AssignCommand(oNPC, ActionMoveToObject(oPC, TRUE, 1.0));
                AssignCommand(oNPC, ActionAttack(oPC));
            }
            else
            {
                DelayCommand(3.0, AssignCommand(oNPC, ActionAttack(oPC)));
            }
        }
        oNPC = GetObjectInArea(sTag, oPC, ++i);
    }
}

void end()
{
    object oPC = GetFirstPC();
    object oTanarukk = CutsceneGetActor("db_tanarukk02");
    object oButcher = CutsceneGetActor("db_thebutcher");

    FadeFromBlack(oPC);

    // make sure the tanarukk is in position
    object oWP = GetObjectByTag("WP_AR1501_CUT1_TANARUKK_CLOSEUP");
    AssignCommand(oTanarukk, ActionMoveToObject(oWP, TRUE, 0.0));

    // move player into the area to avoid enemies bunching up at the
    // .. doors in the resulting combat
    //oWP = GetNearestObjectByTag("WP_AR1501_CUT1_END", oPC);
    oWP = GetWaypointByTag(GetLocalString(GetArea(oPC), "sCutsceneEndWP"));
    TeleportToObject(oPC, oWP, FALSE);

    // orc grunts attack
    AttackPC("db_orcgrunt01", oPC);
    AttackPC("db_orcgrunt02", oPC);
    AttackPC("db_orcarcher", oPC);

    AttackPC("db_droppofforc", oPC);
    AttackPC("db_orcwiza", oPC);

    // goblins are running away
    GoblinsFlee(oPC);

    // tanarukk attacks the player
    AttackPC("db_tanarukk02", oPC);
    AttackPC("db_thebutcher", oPC);
    AttackPC("db_goblinshaman", oPC);
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
