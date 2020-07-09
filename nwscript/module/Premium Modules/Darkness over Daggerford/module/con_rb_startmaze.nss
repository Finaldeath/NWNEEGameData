#include "NW_I0_GENERIC"
#include "x0_i0_petrify"

void InitiateChase(object oPC);
void JuniorHunt(object oJunior, object oPC);

void InitiateChase(object oPC)
{
    int i = 0;

    float fDelay = 2.5;
    float fElapsed = 0.0;

    object oJunior = GetObjectByTag("ac_jonas2");
    object oMazeDoor = GetObjectByTag("ac_dr_maze_pc");

    SetCutsceneMode(oPC, FALSE);
    AssignCommand(oPC, SetCameraFacing(DIRECTION_NORTH, 15.0, -1.0, CAMERA_TRANSITION_TYPE_SNAP));
    SetLocked(oMazeDoor,FALSE);
    AssignCommand(oMazeDoor, ActionOpenDoor(oMazeDoor));

    SetCreatureAppearanceType(oJunior, APPEARANCE_TYPE_WEREWOLF);
    ChangeToStandardFaction(oJunior,STANDARD_FACTION_HOSTILE);
    SetIsTemporaryEnemy(oPC, oJunior);

    ActionDoCommand(ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_HOSTILE));

    for(i = 20; i >=0; i--)
    {
        fElapsed+= fDelay;
        ActionWait(fDelay);
        ActionSpeakString(IntToString(i), TALKVOLUME_SHOUT);
        ActionDoCommand(FloatingTextStringOnCreature(IntToString(i), oPC));
    }

    fElapsed+= fDelay;
    ActionWait(fDelay);
    ActionSpeakString("Your head will make a fine trophy.", TALKVOLUME_SHOUT);
    fElapsed+= fDelay;
    MusicBackgroundChangeDay(GetArea(oJunior), 66);
    MusicBackgroundChangeNight(GetArea(oJunior), 66);
    DelayCommand(fElapsed, SetLocalInt(OBJECT_SELF, "no_banter", 0));
    DelayCommand(fElapsed, ActionJumpToObject(GetWaypointByTag("wp_jonas_maze2")));
    DelayCommand(fElapsed, JuniorHunt(oJunior, oPC));
}

void JuniorHunt(object oJunior, object oPC)
{
    object oPrisonDoor = GetObjectByTag("maze_prison_pc");

    SetLocked(oPrisonDoor, FALSE);
    AssignCommand(oPrisonDoor, ActionOpenDoor(oPrisonDoor));

    if (GetTag(GetArea(oPC)) != "ar0704_chasemaze" ||
        GetLocalInt(oJunior, "iJuniorPursuing") == 0)
    {
        return;
    }

    SoundObjectPlay(GetObjectByTag("ac_snd_werewolf"));
    ExecuteScript("rb_junior_phb", oJunior);
}

void main()
{
    object oJonas = GetObjectByTag("ac_jonas1");
    object oJonasWaypoint = GetWaypointByTag("wp_jonas_maze");
    object oJunior = GetObjectByTag("ac_jonas2");
    object oPC = GetPCSpeaker();
    object oPettywick = GetObjectByTag("ac_pettywick");
    object oPrisonDoor = GetObjectByTag("maze_prison_pc");

    SetLocalInt(oJonas, "no_banter", 1);
    SetLocalInt(oJonas, "iDruggedPC", 0);
    SetLocalInt(oJunior, "iJuniorPursuing", 1);
    SetLocalInt(GetModule(), "iChaseStarted", 1);

    // the henchmen wake up now
    object oRaegen = GetObjectByTag("pm_raegen");
    RemoveEffectOfType(oRaegen, EFFECT_TYPE_SILENCE);
    RemoveEffectOfType(oRaegen, EFFECT_TYPE_SLEEP);
    object oPurfbin = GetObjectByTag("ks_purfbin");
    RemoveEffectOfType(oPurfbin, EFFECT_TYPE_SILENCE);
    RemoveEffectOfType(oRaegen, EFFECT_TYPE_SLEEP);

    AssignCommand(oPettywick, ActionMoveToObject(GetWaypointByTag("wp_pettwick_wait")));
    AssignCommand(oPettywick, ActionDoCommand(SetFacing(DIRECTION_SOUTH)));
    AssignCommand(oJonas, ActionMoveToObject(oJonasWaypoint));
    AssignCommand(oJonas, ActionCloseDoor(oPrisonDoor));
    AssignCommand(oJonas, ActionDoCommand(SetLocked(oPrisonDoor, TRUE)));
    AssignCommand(oJonas, ActionMoveToObject(oJonasWaypoint));
    AssignCommand(oJonas, ActionDoCommand(SetFacing(DIRECTION_NORTH)));
    AssignCommand(oJonas, ActionDoCommand(InitiateChase(oPC)));
}
