/*
    DLA_MEL_INC2.NSS
    gaoneng erick       June 23, 2006

    include for Melee Tournament in Thunderstone : General Melee

    based heavily on the original version by Gale (Jan 11, 2006)
    this rewrite optimizes the performance and weeds out several game-stopping
    bugs

    July 21 : renamed include, functions and constants at Ben's request
*/


// ========
// INCLUDES
// ========

// required for DetermineCombatRound calls
#include "nw_i0_generic"



// =========
// CONSTANTS
// =========

// [ CONTROLS ]

const int DLA_MAX_PCPARTYSIZE  = 3;  // maximum number of party members in pc's party (excludes summonables and possessed)
const int DLA_MAX_PARTICIPANTS = 15; // maximum number of participants in any bout (includes PC and associates but excludes summonables and possessed)
const int DLA_MAX_BOUTSPERDAY  = 2;  // maximum number of melee bouts per day


// [ CUSTOM TOKENS ]

//const int DLA_TOKEN_PC_KILL     = 5000;   // not used
const int DLA_TOKEN_PC_PARTY_KILL = 5001;   // player party number of kills
const int DLA_TOKEN_WINNER        = 5002;   // combatant winner if player lose
const int DLA_TOKEN_WINNER_KILL   = 5003;   // combatant number of kills
//const int DLA_TOKEN_WINNER_PARTY_KILL = 5004;   // not used
const int DLA_TOKEN_PC_HAS_PARTY = 5005;    // if player's alone, ""; else, "and your companions " or "and your companion "
const int DLA_TOKEN_BOUT_COUNT   = 5006;    // number of bouts fought today


// [ COMBAT ]

const string DLA_ENEMY_RESREF = "dla_mel_crea"; // prefix, to be suffixed with a number
const string DLA_ENEMY_TAG    = "dla_mel_c";    // prefix, to be suffixed with a number

//const int DLA_OUTCOME_NONE      = 0;  // final results for player
const int DLA_OUTCOME_WIN       = 1;
const int DLA_OUTCOME_DRAW      = 2;
const int DLA_OUTCOME_LAST_MAN  = 4;
const int DLA_OUTCOME_FOUGHT_BEFORE = 8; // this allows the melee master to recognize if player fought before, doesn't affect outcome


// [ TAGS ]

//const string DLA_WPTAG_TOURNAMENT        = "JP_TTGEndMelee";     // Tournament Area
const string DLA_WPTAG_GENERALMELEE      = "WP_dla_me_end";      // General Melee
const string DLA_WPTAG_GENERALMELEEARENA = "WP_dla_me_start";    // General Melee Arena

const string DLA_WPTAG_SPAWNPOINT        = "wp_mel_"; // prefix for the spawn point, first combatant spawns at wp_mel_1, etc...

const string DLA_CTAG_MELEEMASTER        = "dla_mel_master";     // tag of melee master
const string DLA_ATAG_MELEEAREA          = "dla_mel_area";       // tag of general melee area


// [ VARIABLES ]

// pc party related

const string DLA_PC_PARTY_SIZE      = "GN_PCPARTYSIZE"; // pc party size
const string DLA_PC_PARTY_ID        = "GN_PCPARTYID";   // prefix for each member's id

const string DLA_TEMPMARKER         = "GN_TEMP";        // temporary marker

// arena related

const string DLA_ENEMY_NUMBER_OF = "GN_COMBATANT_NUM"; // final number of combatants spawned
const string DLA_ENEMY_ID        = "GN_COMBATANT_ID";  // prefix for combatant id

const string DLA_DEATHTOLL       = "GN_DEATHTOLL";     // number of dead combatants

const string DLA_NUMBER_OF_KILLS = "GN_NUMKILL";       // number of kills a creature scored

const string DLA_LAST_MELEE_DATE  = "GN_TIME";          // the last time player entered melee
const string DLA_BOUTS_TODAY_NUMBER_OF = "GN_BOUTSTODAY"; // the number of bouts player entered today

// results

const string DLA_OUTCOME          = "GN_OUTCOME";      // win, lose or draw; see DLA_OUTCOME_ const ints above
const string DLA_JUST_FINISH_BOUT = "GN_JUSTFINISH";   // TRUE if player just finished a bout, this allows the melee master to say the proper things



// ==========
// PROTOTYPES
// ==========

// [ PLAYER PARTY CONTROL ]

// setup the calling creature
// this includes resurrecting if dead, force resting and jumping to the
// specified location. This is used for both starting the melee and ending
// the melee.
void dla_SetupCreature(location loc);

// records and returns pc's party size
// this includes PC + henchmen + familiars + animal companions
// but excludes summonables and possessed
// also records the number of henchmen pc has for use later with
// dla_GetInitialNumberOfHenchmen()
int dla_ReturnPCPartySize(object pc);

// jumps pc's party back to start wp
// this is called from dla_EndMeleeTournament to facilitate moving the entire party
void dla_JumpPartyToStart(object pc, object wp);


// [ ARENA MANAGEMENT ]

// spawns in the specified number of combatants and get them to fight
// these combatants are stored as local objects on the area (this facilitates
// clearing them later on)
void dla_SpawnCombatants(int pcpartysize, int maxparticipants = DLA_MAX_PARTICIPANTS);

// clears the arena of all combatants
void dla_DestroyCombatants(object pc, int pcpartysize, int maxparticipants = DLA_MAX_PARTICIPANTS);

// called by a dead combatant
// this records the killer, and if all combatants are dead, starts the end sequence
void dla_IAmDead();

// this is the master function that setups the arena
// includes resetting variables, setting up pc's party and spawning in combatants
void dla_StartMeleeTournament(object pc, int maxparticipants = DLA_MAX_PARTICIPANTS);

// this is the master functions that ends a bout
// includes restoring pc's party, clearing arena, setting tokens and tabulating
// results
void dla_EndMeleeTournament(object pc, int islastman = TRUE);

// called from dla_EndMeleeTournament() if player is killed
// NOTE : misnomer. What this really does is to assign the leftover combatants to
// the most powerful one, i.e. assign kill count
void dla_EndPCDied(object pc);

// called from dla_EndMeleeTournament()
// checks for creature with highest kill and set the appropriate custom tokens
void dla_CalculateOutcomeAndSetTokens(object pc, object area);


// [ DATE TIME ]

// returns date in the form of YEAR_MONTH_DAY
string dla_GetDate();

// returns TRUE if pc is allowed to enter bout today
// this check if it's a new day and if number of bouts per day is exceeded
int dla_GetCanEnter(object pc);


// ===============
// IMPLEMENTATIONS
// ===============

void dla_SetupCreature(location loc)
{
    object self = OBJECT_SELF;
    if (GetIsDead(self)) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), self);
    ForceRest(self); // this removes all summons and buffs
    ClearAllActions(TRUE);
    ActionJumpToLocation(loc);
    ActionWait(1.5);
}

int dla_ReturnPCPartySize(object pc)
{
    int i = 1, henchnum = 1;  // i = 1 because pc counts as 1
    object assoc;

    object hench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, pc, henchnum);
    while (GetIsObjectValid(hench))
    {
        SetLocalObject(pc, DLA_PC_PARTY_ID + IntToString(++i), hench);
        assoc = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, hench);
        if (GetIsObjectValid(assoc)) SetLocalObject(pc, DLA_PC_PARTY_ID + IntToString(++i), assoc);
        assoc = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, hench);
        if (GetIsObjectValid(assoc)) SetLocalObject(pc, DLA_PC_PARTY_ID + IntToString(++i), assoc);
        hench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, pc, ++henchnum);
    }

    assoc = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, pc);
    if (GetIsObjectValid(assoc)) SetLocalObject(pc, DLA_PC_PARTY_ID + IntToString(++i), assoc);
    assoc = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, pc);
    if (GetIsObjectValid(assoc)) SetLocalObject(pc, DLA_PC_PARTY_ID + IntToString(++i), assoc);

    // ignores all other associate types, those will be removed prior to combat
    SetLocalInt(pc, DLA_PC_PARTY_SIZE, i);
    return i;
}

// this is necessary so the spawning can be delayed ... this reduces the starting lag somewhat
// s = resref id, delay = delay to DetermineCombatRound
void dla_ActionSpawnCombatant(object area, string s, float delay)
{
    object combatant = CreateObject(OBJECT_TYPE_CREATURE,
                                    DLA_ENEMY_RESREF + s,
                                    GetLocation(GetWaypointByTag(DLA_WPTAG_SPAWNPOINT + s)),
                                    FALSE,
                                    DLA_ENEMY_TAG + s);
    AssignCommand(combatant, SetIsDestroyable(FALSE, FALSE));
    AssignCommand(combatant, DelayCommand(delay, DetermineCombatRound()));
    SetLocalObject(area, DLA_ENEMY_ID + s, combatant);
}

void dla_SpawnCombatants(int pcpartysize, int maxparticipants = DLA_MAX_PARTICIPANTS)
{
    int i;
    object combatant, area = GetArea(OBJECT_SELF);
    float f = IntToFloat(pcpartysize) * 0.11, g, h = IntToFloat(maxparticipants) * 0.11;
    for (i = maxparticipants; i > pcpartysize; i--)
    {
        g = IntToFloat(i) * 0.11 - f;
        DelayCommand(g, dla_ActionSpawnCombatant(area, IntToString(i), h - g));
    }
    SetLocalInt(area, DLA_ENEMY_NUMBER_OF, maxparticipants - pcpartysize);
}

void dla_DestroyCombatants(object pc, int pcpartysize, int maxparticipants = DLA_MAX_PARTICIPANTS)
{
    int i;
    string s;
    object combatant, area = GetArea(pc);
    for (i = maxparticipants; i > pcpartysize; i--)
    {
        s = DLA_ENEMY_ID + IntToString(i);
        combatant = GetLocalObject(area, s);
        AssignCommand(combatant, SetIsDestroyable(TRUE));
        AssignCommand(combatant, ClearAllActions(TRUE));
        DestroyObject(combatant, 1.0); // no need to clear the combatant's inventory if those items are not droppable and random treasure if OFF
        DeleteLocalObject(area, s);
    }
    DeleteLocalInt(area, DLA_DEATHTOLL);
    DeleteLocalInt(area, DLA_ENEMY_NUMBER_OF);
}

void dla_IAmDead()
{
    object self = OBJECT_SELF;
    object area = GetArea(self);
    int deathtoll = GetLocalInt(area, DLA_DEATHTOLL) + 1;
    SetLocalInt(area, DLA_DEATHTOLL, deathtoll);

    object killer = GetLastKiller();
    object master = GetMaster(killer);
    while (GetIsObjectValid(master))
    {
        killer = master;
        master = GetMaster(killer);
    }
    SetLocalInt(killer, DLA_NUMBER_OF_KILLS, GetLocalInt(killer, DLA_NUMBER_OF_KILLS) + 1);

    if (deathtoll == GetLocalInt(area, DLA_ENEMY_NUMBER_OF))
    {
        if (GetIsPC(killer)) AssignCommand(killer,dla_EndMeleeTournament(killer));
        else AssignCommand(killer,dla_EndMeleeTournament(OBJECT_SELF)); // fallback - THIS SHOULD NEVER EVER HAPPEN
    }
//    WriteTimestampedLogEntry(GetName(OBJECT_SELF) + " is dead and deathtoll = " + IntToString(deathtoll));
}

void dla_StartMeleeTournament(object pc, int maxparticipants = DLA_MAX_PARTICIPANTS)
{
    object area = GetArea(OBJECT_SELF);
    location loc = GetLocation(GetWaypointByTag(DLA_WPTAG_GENERALMELEEARENA));
    int pcpartysize = dla_ReturnPCPartySize(pc);

    // reset combat result
    SetLocalInt(pc, DLA_OUTCOME, DLA_OUTCOME_FOUGHT_BEFORE);
    SetLocalString(pc, DLA_LAST_MELEE_DATE, dla_GetDate());
    DeleteLocalInt(pc, DLA_NUMBER_OF_KILLS);

    AssignCommand(pc, dla_SetupCreature(loc));
    int i;
    for (i = pcpartysize; i > 1; i--) AssignCommand(GetLocalObject(pc, DLA_PC_PARTY_ID + IntToString(i)), dla_SetupCreature(loc));

    dla_SpawnCombatants(pcpartysize, maxparticipants);

    BlackScreen(pc);
    DelayCommand(0.6, FadeFromBlack(pc));
}

void dla_EndMeleeTournament(object pc, int islastman = TRUE)
{
    object area = GetArea(pc);

    if (islastman) SetLocalInt(pc, DLA_OUTCOME, GetLocalInt(pc, DLA_OUTCOME) | DLA_OUTCOME_LAST_MAN); // flag as last man standing
    else dla_EndPCDied(pc); // distribute remaining kill counts to combatant with highest hitpoint left

    // mini-cutscene with some camera movement ... nothing much really
    float facing = GetFacing(pc) + 180.0;
    SetCutsceneMode(pc);
    AssignCommand(pc, ClearAllActions(TRUE));
    if (islastman) AssignCommand(pc, DelayCommand(0.5, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1)));
    AssignCommand(pc, SetCameraFacing(facing, 10.0, 45.0 , CAMERA_TRANSITION_TYPE_SNAP));
    AssignCommand(pc, SetCameraFacing(facing, 20.0, 60.0 , CAMERA_TRANSITION_TYPE_MEDIUM));
    DelayCommand(3.5, BlackScreen(pc));
    DelayCommand(4.0, FadeFromBlack(pc));
    DelayCommand(4.1, SetCutsceneMode(pc, FALSE));

    // restore and jump party back to start location
    DelayCommand(3.6, dla_JumpPartyToStart(pc, GetWaypointByTag(DLA_WPTAG_GENERALMELEE)));

    DelayCommand(4.2, AssignCommand(pc, ActionStartConversation(GetNearestObjectByTag(DLA_CTAG_MELEEMASTER))));

    dla_CalculateOutcomeAndSetTokens(pc, area);
    dla_DestroyCombatants(pc, GetLocalInt(pc, DLA_PC_PARTY_SIZE));
    SetLocalInt(pc, DLA_JUST_FINISH_BOUT, TRUE);

    BlackScreen(pc);
    FadeFromBlack(pc);
}

void dla_JumpPartyToStart(object pc, object wp)
{
    location loc = GetLocation(wp);
    AssignCommand(pc, dla_SetupCreature(loc));
    int i, j, pcpartysize = GetLocalInt(pc, DLA_PC_PARTY_SIZE);
    object assoc, summon;
    for (i = pcpartysize; i > 1; i--)
    {
        assoc = GetLocalObject(pc, DLA_PC_PARTY_ID + IntToString(i));
        AssignCommand(assoc, DelayCommand(1.5, dla_SetupCreature(loc)));
        SetLocalInt(assoc, DLA_TEMPMARKER, TRUE);
        DelayCommand(1.0, DeleteLocalInt(assoc, DLA_TEMPMARKER));
        summon = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, assoc);     // typically unnecessary, since NPCs will never summon familiars anyway.. but just in case players are using modified A.I.
        if (GetIsObjectValid(summon)) AssignCommand(summon, dla_SetupCreature(loc));
        summon = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, assoc);
        if (GetIsObjectValid(summon)) AssignCommand(summon, dla_SetupCreature(loc));
    }
    summon = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, pc); // this TEMPMARKER thing is in case player summoned them during combat
    if (GetIsObjectValid(summon) && !GetLocalInt(summon, DLA_TEMPMARKER)) AssignCommand(summon, dla_SetupCreature(loc));
    summon = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, pc);
    if (GetIsObjectValid(summon) && !GetLocalInt(summon, DLA_TEMPMARKER)) AssignCommand(summon, dla_SetupCreature(loc));
}

void dla_EndPCDied(object pc)
{
    int hp, hphighest;
    object alive, mostalive;
    object area = GetArea(pc);
    int i, numalive;
    string s;
    int maxparticipants = DLA_MAX_PARTICIPANTS,
        pcpartysize = GetLocalInt(pc, DLA_PC_PARTY_SIZE);
    for (i = maxparticipants; i > pcpartysize; i--)
    {
        s = DLA_ENEMY_ID + IntToString(i);
        alive = GetLocalObject(area, s);
        AssignCommand(alive, ClearAllActions(TRUE));
        hp = GetCurrentHitPoints(alive);
        if (hp > 0)
        {
            numalive++;
            if (hp >= hphighest)
            {
                hphighest = hp;
                mostalive = alive;
            }
        }
    }                                                                                             // assume player killed by mostalive too, so additional count here.
    if (numalive > 1) SetLocalInt(mostalive, DLA_NUMBER_OF_KILLS, GetLocalInt(mostalive, DLA_NUMBER_OF_KILLS) + numalive);
//    WriteTimestampedLogEntry("dla_EndPCDied fired with numalive = " + IntToString(numalive));
}

void dla_CalculateOutcomeAndSetTokens(object pc, object area)
{
    int i;
    string s;
    object mostkill, combatant, area = GetArea(OBJECT_SELF);

    // check for combatant with highest kill count
    int kill, killhighest;
    int maxparticipants = DLA_MAX_PARTICIPANTS, pcpartysize = GetLocalInt(pc, DLA_PC_PARTY_SIZE);
    for (i = maxparticipants; i > pcpartysize; i--)
    {
        s = DLA_ENEMY_ID + IntToString(i);
        combatant = GetLocalObject(area, s);
        kill = GetLocalInt(combatant, DLA_NUMBER_OF_KILLS);
        if (kill > killhighest)
        {
            killhighest = kill; mostkill = combatant;
        }
    }

    // record player kill count
    kill = GetLocalInt(pc, DLA_NUMBER_OF_KILLS);
    SetCustomToken(DLA_TOKEN_PC_PARTY_KILL, IntToString(kill));

    // check if player has more kills than combatant
    int outcome = GetLocalInt(pc, DLA_OUTCOME);
    if (kill > killhighest)
    {
        killhighest = kill; mostkill = pc;
        outcome = outcome | DLA_OUTCOME_WIN;
    }
    else if (kill == killhighest)
    {
        outcome = outcome | DLA_OUTCOME_DRAW; // it's a draw
        if (outcome & DLA_OUTCOME_LAST_MAN)
        {
            mostkill = pc;
            outcome = outcome | DLA_OUTCOME_WIN;  // but consider pc won because pc is last man standing
        }
    }
    SetLocalInt(pc, DLA_OUTCOME, outcome);

    // record highest kill count and winner
    SetCustomToken(DLA_TOKEN_WINNER_KILL, IntToString(killhighest));
    SetCustomToken(DLA_TOKEN_WINNER, GetName(mostkill));

    // check if player has companions initially
    if (pcpartysize > 2)      SetCustomToken(DLA_TOKEN_PC_HAS_PARTY, "and your companions ");
    else if (pcpartysize > 1) SetCustomToken(DLA_TOKEN_PC_HAS_PARTY, "and your companion ");
    else                      SetCustomToken(DLA_TOKEN_PC_HAS_PARTY, "");

    // set number of bouts
    int bout = GetLocalInt(pc, DLA_BOUTS_TODAY_NUMBER_OF) + 1;
    SetLocalInt(pc, DLA_BOUTS_TODAY_NUMBER_OF, bout);
    SetCustomToken(DLA_TOKEN_BOUT_COUNT, IntToString(bout));
}

string dla_GetDate()
{
    return IntToString(GetCalendarYear()) + "_" +
           IntToString(GetCalendarMonth()) + "_" +
           IntToString(GetCalendarDay());
}

int dla_GetCanEnter(object pc)
{   // realistically speaking, if the tournament is daily, then as long as GetDate is different, player should be able to reenter (no need to check for 24 hours)
    if (dla_GetDate() != GetLocalString(pc, DLA_LAST_MELEE_DATE))
    {   // a day has passed, so reset and return true
//        DeleteLocalInt(pc, DLA_LAST_MELEE_DATE);
        DeleteLocalInt(pc, DLA_BOUTS_TODAY_NUMBER_OF);
        return TRUE;
    }
    if (GetLocalInt(pc, DLA_BOUTS_TODAY_NUMBER_OF) < DLA_MAX_BOUTSPERDAY) return TRUE; // day not passed, but number of bouts not exceeded
    return FALSE;
}
