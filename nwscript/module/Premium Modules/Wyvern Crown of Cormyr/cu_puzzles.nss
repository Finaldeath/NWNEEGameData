/*
    CU_PUZZLES.nss
    include for Castle Wyvernwater : Basement mirror puzzle

    gaoneng    March 27, 2006

    Please do not edit unless you know what you're doing.

    To edit values of tags and resrefs, or to edit the visual effects to use, or
    to edit anything at all, simply change the corresponding value in the
    CONSTANTS list. Do not edit the functions unless you know what you're doing.
*/

// **** CONSTANTS *************************************************************

// tags of various objects
const string GN_TAG_EMITTER1 = "CWBShooter1";    // the statue emitting the beam
const string GN_TAG_EMITTER2 = "CWBShooter2";
const string GN_TAG_TARGET1  = "CWBTarget1";     // the statue receiving the beam
const string GN_TAG_TARGET2  = "CWBTarget2";
const string GN_TAG_DOOR1    = "CWBDoorPuzzle2"; // the door to be opened
const string GN_TAG_DOOR2    = "CWBDoorPuzzle1"; // reversed for unknown reasons, preserved from previous version
const string GN_TAG_BLOCKER1 = "WP_CWBCorrect1"; // the center of the statue pairs
const string GN_TAG_BLOCKER2 = "WP_CWBCorrect2";
const string GN_TAG_RELAY    = "CWBRelay";       // the beam relay for group 1
const string GN_TAG_AREA     = "CWB";            // Castle Wyvernwater Basement area tag

// resrefs of various objects
const string GN_RES_MIRROR_P = "silvermirror_plc";  // the mirror placeable
const string GN_RES_MIRROR_I = "silvermirror";      // the mirror item
const string GN_RES_BLOCKER  = "x0_largebench";     // the blocking placeable

const float GN_MINDIST       = 3.0f;  // minimum distance between mirror and statue

// variable prefixes
const string GN_VAR_EMITTER  = "GN_CWBEMIT";
const string GN_VAR_TARGET   = "GN_CWBTARG";
const string GN_VAR_DOOR     = "GN_CWBDOOR";
const string GN_VAR_BLOCKER  = "GN_CWBBLOC";
const string GN_VAR_RELAY    = "GN_CWBRELAY";
const string GN_VAR_MIRROR   = "GN_CWBMIRR";

    // sum of beam types. so 26 would mean 2, 8, 16 is on.
    //  1 - emitter to target
    //  2 - emitter to mirror
    //  4 - mirror to door
    //  8 - mirror to relay
    // 16 - relay to door
    // 32 - emitter to mirror (bad pos)
const string GN_VAR_BEAM     = "GN_CWBBEAM";

// visual effects
const int GN_VFX_BEAM1       = VFX_BEAM_SILENT_HOLY; // for 1 and 2
const int GN_VFX_BEAM2       = VFX_BEAM_SILENT_EVIL; // for 4, 8 and 16
const int GN_VFX_BEAM3       = VFX_BEAM_BLACK;       // for 32
const int GN_VFX_KNOCK       = VFX_IMP_KNOCK;        // for when door's unlocked

// misc variable prefixes
const string GN_VAR_WPBLOCK  = "GN_BLOCK";  // used to tie physical blocker to waypoint
const string GN_VAR_DIST     = "GN_DIST";   // distance between mirror and emitter



// **** STRUCT *****************************************************************
struct gn_Assembly
{
    object emitter;
    object target;
    object door;
    object blocker;
    object mirror;
    float dist;
    int beam;
};

struct gn_Assembly gn_GetAssembly(object area, string s);
struct gn_Assembly gn_GetAssembly(object area, string s)
{
    struct gn_Assembly str;
    str.emitter = GetLocalObject(area, GN_VAR_EMITTER + s);
    str.target  = GetLocalObject(area, GN_VAR_TARGET + s);
    str.door    = GetLocalObject(area, GN_VAR_DOOR + s);
    str.blocker = GetLocalObject(area, GN_VAR_BLOCKER + s);
    str.mirror  = OBJECT_INVALID;
    str.dist    = 0.0;
    str.beam    = GetLocalInt(area, GN_VAR_BEAM + s);
    return str;
}

void gn_SetLocalStruct(struct gn_Assembly str, object area, string s);
void gn_SetLocalStruct(struct gn_Assembly str, object area, string s)
{
    SetLocalObject(area, GN_VAR_EMITTER + s, str.emitter);
    SetLocalObject(area,  GN_VAR_TARGET + s, str.target);
    SetLocalObject(area,    GN_VAR_DOOR + s, str.door);
    SetLocalObject(area, GN_VAR_BLOCKER + s, str.blocker);
    SetLocalInt(area, GN_VAR_BEAM + s, str.beam);
}


// **** PROTOTYPES *************************************************************

// **** minor functions (generally not for external use)

// creates an invisible blocking object at waypoint's location
void gn_BlockPassage(object waypoint);

// removes blocking object from waypoint
void gn_UnblockPassage(object waypoint);

// closes and locks door
void gn_LockDoor(object door);

// unlocks door
void gn_UnlockDoor(object door);

// creates a mirror placeable, destroys mirror item, and then calls gn_CWBMirrorCheck
void gn_PlaceMirror(object pc, object item);

// destroys mirror placeable, creates mirror item, and then calls gn_CWBMirrorCheck
void gn_RemoveMirror(object pc, object plc);

// continual beam vfx linking every 3 seconds
void gn_LinkWithBeam(object area, string s, int num, object target, object source, int beam);

// turn off all beam vfx in area
void gn_ResetBeamsToNone(object area);

// remove all beam vfx from obj
void gn_RemoveBeamEffects(object obj);

// start assigning beam vfx to objects
void gn_ProcessBeam(object area, struct gn_Assembly grp1, struct gn_Assembly grp2);

// process result after mirror validity check. This performs the appropriate
// actions, including blocking the passage, applying the beam fx, and locking doors
void gn_ProcessResult(object area, struct gn_Assembly grp1, struct gn_Assembly grp2, int flag);


// **** main functions

// setups area by recording important objects and creating blockers
// automatically calls gn_CWBMirrorCheck after setting up
// WARNING : should only ever be called by an AREA object
void gn_CWBSetupArea();

// checks mirrors' validity and then performs appropriate actions
void gn_CWBMirrorCheck();



// **** IMPLEMENTATION *********************************************************

void gn_BlockPassage(object waypoint)
{
    object block = GetLocalObject(waypoint, GN_VAR_WPBLOCK);
    if (GetIsObjectValid(block)) return;
    block = CreateObject(OBJECT_TYPE_PLACEABLE, GN_RES_BLOCKER, GetLocation(waypoint));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        SupernaturalEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY)),
                        block);
    SetPlotFlag(block, TRUE);
    SetLocalObject(waypoint, GN_VAR_WPBLOCK, block);
}

void gn_UnblockPassage(object waypoint)
{
    DestroyObject(GetLocalObject(waypoint, GN_VAR_WPBLOCK));
    DeleteLocalObject(waypoint, GN_VAR_WPBLOCK);
}

void gn_LockDoor(object door)
{
    AssignCommand(door, ActionCloseDoor(OBJECT_SELF));
    SetLocked(door, TRUE);
}

void gn_UnlockDoor(object door)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(GN_VFX_KNOCK), door);
    SetLocked(door, FALSE);
}

void gn_PlaceMirror(object pc, object item)
{
    object area = GetArea(pc);

    if (GetTag(area) != GN_TAG_AREA)
    {   // if we're not in Basement, simply create placeable and be done
        CreateObject(OBJECT_TYPE_PLACEABLE, GN_RES_MIRROR_P, GetLocation(pc));
        return;
    }
        // else, setup the mirror placeable properly
    vector pos = GetPosition(pc);
    float face;

    struct gn_Assembly grp1 = gn_GetAssembly(area, "1");
    struct gn_Assembly grp2 = gn_GetAssembly(area, "2");

    float dist1 = GetDistanceBetween(pc, grp1.blocker),
          dist2 = GetDistanceBetween(pc, grp2.blocker);
                        // compare distance, mirror always faces the closest statue
    if (dist1 < dist2) face = VectorToAngle(pos - GetPosition(grp1.emitter));
    else               face = VectorToAngle(pos - GetPosition(grp2.emitter));

    object plc = CreateObject(OBJECT_TYPE_PLACEABLE, GN_RES_MIRROR_P, Location(area, pos, face));

    string s = "A";
    if (GetIsObjectValid(GetLocalObject(area, GN_VAR_MIRROR + s))) s = "B";
    SetLocalObject(area, GN_VAR_MIRROR + s, plc);
                        // record distances now, so we don't have to compare again later
    AssignCommand(plc, SetLocalFloat(OBJECT_SELF, GN_VAR_DIST + "1", dist1));
    AssignCommand(plc, SetLocalFloat(OBJECT_SELF, GN_VAR_DIST + "2", dist2));
    AssignCommand(plc, SetLocalString(OBJECT_SELF, "GN_S", s));

    DestroyObject(item);
    AssignCommand(area, DelayCommand(1.0, gn_CWBMirrorCheck()));
}

void gn_RemoveMirror(object pc, object plc)
{
    object area = GetArea(pc);

    if (GetTag(area) != GN_TAG_AREA)
    {
        DestroyObject(plc);
        return;
    }

    AssignCommand(area, DelayCommand(1.0, gn_CWBMirrorCheck()));
    CreateItemOnObject(GN_RES_MIRROR_I, pc);

    string s = GetLocalString(plc, "GN_S");
    DeleteLocalObject(area, GN_VAR_MIRROR + s);
    DeleteLocalString(plc, "GN_S");
    DeleteLocalFloat(plc, GN_VAR_DIST + "1"); // Erick sez - folklore : DestroyObject doesn't clear the locals,
    DeleteLocalFloat(plc, GN_VAR_DIST + "2"); // but instead leaves them floating around, so we manually remove
    DestroyObject(plc);                       // these to free up memory. Read : FOLKLORE. If t'is true, great;
}                                             // else, there's no harm either. ;)

void gn_ResetBeamsToNone(object area)
{
    gn_RemoveBeamEffects(GetLocalObject(area, GN_VAR_EMITTER + "1"));
    gn_RemoveBeamEffects(GetLocalObject(area, GN_VAR_EMITTER + "2"));
    gn_RemoveBeamEffects(GetLocalObject(area, GN_VAR_MIRROR + "A"));
    gn_RemoveBeamEffects(GetLocalObject(area, GN_VAR_MIRROR + "B"));
    gn_RemoveBeamEffects(GetLocalObject(area, GN_VAR_RELAY));
    DeleteLocalInt(area, GN_VAR_BEAM + "1");
    DeleteLocalInt(area, GN_VAR_BEAM + "2");
}

void gn_RemoveBeamEffects(object obj)
{
    effect e = GetFirstEffect(obj);
    while (GetIsEffectValid(e))
    {
        if (GetEffectType(e) == EFFECT_TYPE_BEAM) RemoveEffect(obj, e);
        e = GetNextEffect(obj);
    }
}

void gn_LinkWithBeam(object area, string s, int num, object target, object source, int beam)
{   // 1 emit-target, 2 emit-mirror yellow, 4 mirror-door red, 8 mirror-relay red, 16 relay-door red, 32 emit-mirror black
    if (GetLocalInt(area, GN_VAR_BEAM + s) & num)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            SupernaturalEffect(EffectBeam(beam, source, BODY_NODE_CHEST)),
                            target, 2.9);
//        WriteTimestampedLogEntry(GetTag(source) + " and " + GetTag(target) + " linked in iteration " + IntToString(loop) );
        DelayCommand(3.0, gn_LinkWithBeam(area, s, num, target, source, beam));
    }
}

void gn_ProcessBeam(object area, struct gn_Assembly grp1, struct gn_Assembly grp2)
{
    object relay = GetLocalObject(area, GN_VAR_RELAY);

    if (grp1.beam & 1)  gn_LinkWithBeam(area, "1",  1, grp1.emitter, grp1.target, GN_VFX_BEAM1);
    if (grp1.beam & 2)  gn_LinkWithBeam(area, "1",  2, grp1.emitter, grp1.mirror, GN_VFX_BEAM1);
    if (grp1.beam & 8)  gn_LinkWithBeam(area, "1",  8, grp1.mirror, relay,        GN_VFX_BEAM2);
    if (grp1.beam & 16) gn_LinkWithBeam(area, "1", 16, relay, grp1.door,          GN_VFX_BEAM2);
    if (grp1.beam & 32) gn_LinkWithBeam(area, "1", 32, grp1.emitter, grp1.mirror, GN_VFX_BEAM3);

    if (grp2.beam & 1)  gn_LinkWithBeam(area, "2",  1, grp2.emitter, grp2.target, GN_VFX_BEAM1);
    if (grp2.beam & 2)  gn_LinkWithBeam(area, "2",  2, grp2.emitter, grp2.mirror, GN_VFX_BEAM1);
    if (grp2.beam & 4)  gn_LinkWithBeam(area, "2",  4, grp2.mirror, grp2.door,    GN_VFX_BEAM2);
    if (grp2.beam & 32) gn_LinkWithBeam(area, "2", 32, grp2.emitter, grp2.mirror, GN_VFX_BEAM3);
}

void gn_ProcessResult(object area, struct gn_Assembly grp1, struct gn_Assembly grp2, int flag)
{
    grp1.beam = 0; grp2.beam = 0;

    if (flag == 3) // both groups unlocked
    {
        gn_UnblockPassage(grp1.blocker);             // unblock both passages
        gn_UnblockPassage(grp2.blocker);
        DelayCommand(2.5, gn_UnlockDoor(grp1.door)); // unlock both doors
        DelayCommand(2.5, gn_UnlockDoor(grp2.door));
        grp1.beam ^= 26; grp2.beam ^= 6;             // turn on the appropriate beams
        SetLocalInt(area, GN_VAR_BEAM + "1", grp1.beam);
        SetLocalInt(area, GN_VAR_BEAM + "2", grp2.beam);
        AssignCommand(area, gn_ProcessBeam(area, grp1, grp2));
        return;
    }

    gn_LockDoor(grp1.door);        // else, lock and close all doors
    gn_LockDoor(grp2.door);

    if (flag & 1)                  // only group 1 unlocked
    {
        gn_UnblockPassage(grp1.blocker);
        gn_BlockPassage(grp2.blocker);
        grp1.beam ^= 26;
        grp2.beam ^= 1;
    }
    else if (flag & 2)             // only group 2 unlocked
    {
        gn_BlockPassage(grp1.blocker);
        gn_UnblockPassage(grp2.blocker);
        grp1.beam ^= 1;
        grp2.beam ^= 6;
    }
    else                           // both unlocked
    {
        gn_BlockPassage(grp1.blocker);
        gn_BlockPassage(grp2.blocker);
        grp1.beam ^= 1; grp2.beam ^= 1;
    }
    // 1 emit-target, 2 emit-mirror yellow, 4 mirror-door red, 8 mirror-relay red, 16 relay-door red, 32 emit-mirror black
    if (flag & 4) grp1.beam ^= 32;    // group 1 Line of Sight
    if (flag & 8) grp2.beam ^= 32;    // group 2 Line of Sight

    SetLocalInt(area, GN_VAR_BEAM + "1", grp1.beam);
    SetLocalInt(area, GN_VAR_BEAM + "2", grp2.beam);
    AssignCommand(area, DelayCommand(1.0, gn_ProcessBeam(area, grp1, grp2)));
}

void gn_CWBSetupArea()
{
    object self = OBJECT_SELF; // refers to area

    if (GetTag(self) != GN_TAG_AREA) return;

    object o;
    string s;
    struct gn_Assembly grp1, grp2;
    o = GetFirstObjectInArea(self);
    while (GetIsObjectValid(o))    // loop through area and start matching tags with objects
    {
        s = GetTag(o);
        if      (s == GN_TAG_EMITTER1)  grp1.emitter = o;
        else if (s == GN_TAG_EMITTER2)  grp2.emitter = o;
        else if (s == GN_TAG_RELAY)     SetLocalObject(self, GN_VAR_RELAY, o);
        else if (s == GN_TAG_DOOR1)     grp1.door = o;
        else if (s == GN_TAG_DOOR2)     grp2.door = o;
        else if (s == GN_TAG_TARGET1)   grp1.target = o;
        else if (s == GN_TAG_TARGET2)   grp2.target = o;
        else if (s == GN_TAG_BLOCKER1)
        {
            grp1.blocker = o;
            AssignCommand(o, DelayCommand(2.0, gn_BlockPassage(OBJECT_SELF)));
        }
        else if (s == GN_TAG_BLOCKER2)
        {
            grp2.blocker = o;
            AssignCommand(o, DelayCommand(2.0, gn_BlockPassage(OBJECT_SELF)));
        }
        o = GetNextObjectInArea(self);
    }
    gn_SetLocalStruct(grp1, self, "1");
    gn_SetLocalStruct(grp2, self, "2");
    DelayCommand(2.0, gn_CWBMirrorCheck());
}

void gn_CWBMirrorCheck()
{
    object area = GetArea(OBJECT_SELF); // should == OBJECT_SELF anyway, but preserved from old script

    if (GetTag(area) != GN_TAG_AREA) return;

    struct gn_Assembly grp1 = gn_GetAssembly(area, "1"); // retrieve all the objects and data we need
    struct gn_Assembly grp2 = gn_GetAssembly(area, "2"); // such as the various placeables

    gn_ResetBeamsToNone(area); // remove all effects temporarily (this allows the continual looping of beam fx to stop)

    object mira = GetLocalObject(area, GN_VAR_MIRROR + "A"),
           mirb = GetLocalObject(area, GN_VAR_MIRROR + "B");
    int maval = GetIsObjectValid(mira), mbval = GetIsObjectValid(mirb), flag = 0;
    float dista1 = GetLocalFloat(mira, GN_VAR_DIST + "1"),
          dista2 = GetLocalFloat(mira, GN_VAR_DIST + "2"),
          distb1 = GetLocalFloat(mirb, GN_VAR_DIST + "1"),
          distb2 = GetLocalFloat(mirb, GN_VAR_DIST + "2");

    if (maval && mbval) // blah blah, basically this entire chunk compares the distances between
    {                   // the mirrors and statues and then determine the flagstate of the groups
        if (dista1 < distb1)   // then dista2 must be > distb2
        {
            grp1.mirror = mira; grp2.mirror = mirb;
            grp1.dist = dista1; grp2.dist = distb2;
        }
        else
        {
            grp1.mirror = mirb; grp2.mirror = mira;
            grp1.dist = distb1; grp2.dist = dista2;
        }
        if (grp1.dist < GN_MINDIST) flag ^= 1; // 1 - group1 on, 2 - group2 on, 4 - mirror LOS group1, 8 - mirror LOS group2
        else if (LineOfSightObject(grp1.mirror, grp1.emitter)) flag ^= 4;
        if (grp2.dist < GN_MINDIST) flag ^= 2;
        else if (LineOfSightObject(grp2.mirror, grp2.emitter)) flag ^= 8;
    }
    else if (maval)
    {
        if (dista1 < dista2)
        {
            grp1.mirror = mira; grp1.dist = dista1;
            if (grp1.dist < GN_MINDIST) flag ^= 1;
            else if (LineOfSightObject(grp1.mirror, grp1.emitter)) flag ^= 4;
        }
        else
        {
            grp2.mirror = mira; grp2.dist = dista2;
            if (grp2.dist < GN_MINDIST) flag ^= 2;
            else if (LineOfSightObject(grp2.mirror, grp2.emitter)) flag ^= 8;
        }
    }
    else if (mbval)
    {
        if (distb1 < distb2)
        {
            grp1.mirror = mirb; grp1.dist = distb1;
            if (grp1.dist < GN_MINDIST) flag ^= 1;
            else if (LineOfSightObject(grp1.mirror, grp1.emitter)) flag ^= 4;
        }
        else
        {
            grp2.mirror = mirb; grp2.dist = distb2;
            if (grp2.dist < GN_MINDIST) flag ^= 2;
            else if (LineOfSightObject(grp2.mirror, grp2.emitter)) flag ^= 8;
       }
    }
    DelayCommand(3.0, gn_ProcessResult(area, grp1, grp2, flag));
}


// **** OLD SCRIPT (preserved for history) *************************************

/*
// January 2006
// B W-Husey
// Include for puzzles

#include "x0_i0_petrify"

// Does a check of where the mirrors are and applies the effects. Wyvernwater basement puzzle.
void MirrorCheck(object oPC);

void MirrorCheck(object oPC)
{
   if (GetTag(GetArea(OBJECT_SELF))=="CWB")
   {
        //************Debug line**************
//        SendMessageToPC(oPC,"Mirror check run");
        object oShoot1 = GetObjectByTag("CWBShooter1");
        object oShoot2 = GetObjectByTag("CWBShooter2");
        object oCentre = GetObjectByTag("MirrorChecker");
        object oRelay = GetObjectByTag("CWBRelay");

// Erick - removed
//        object oBlock1a = GetObjectByTag("CWBTrigBlock1a");
//        object oBlock2a = GetObjectByTag("CWBTrigBlock2a");
//        object oBlock1b = GetObjectByTag("CWBTrigBlock1b");
//        object oBlock2b = GetObjectByTag("CWBTrigBlock2b");

        object oMirror1 = GetNearestObjectByTag("SilverMirrorPLC",oCentre,1);
        object oMirror2 = GetNearestObjectByTag("SilverMirrorPLC",oCentre,2);

        object oDoor1 =  GetObjectByTag("CWBDoorPuzzle2");//Note this is reversed
        object oDoor2 =  GetObjectByTag("CWBDoorPuzzle1");

        object oTarget1 = GetObjectByTag("CWBTarget1");
        object oTarget2 = GetObjectByTag("CWBTarget2");

        object oWayRight1 = GetWaypointByTag("WP_CWBCorrect1");
        object oWayRight2 = GetWaypointByTag("WP_CWBCorrect2");
        object oWrong = GetObjectByTag("CWBWrong");  // Erick sez - what does this do?

        effect eBeam1 = EffectBeam(VFX_BEAM_SILENT_HOLY, oShoot1, BODY_NODE_CHEST);
        effect eBeam1b =  EffectBeam(VFX_BEAM_SILENT_EVIL, oRelay, BODY_NODE_CHEST);
        effect eBeam2 = EffectBeam(VFX_BEAM_SILENT_HOLY, oShoot2, BODY_NODE_CHEST);
        effect eBeam1w = EffectBeam(VFX_BEAM_BLACK, oMirror1, BODY_NODE_CHEST);
        effect eBeam2w = EffectBeam(VFX_BEAM_BLACK, oMirror2, BODY_NODE_CHEST);
        effect eBeam3 = EffectBeam(VFX_BEAM_SILENT_EVIL, oMirror1, BODY_NODE_CHEST);
        effect eBeam4 = EffectBeam(VFX_BEAM_SILENT_EVIL, oMirror2, BODY_NODE_CHEST);
        effect eKnock = EffectVisualEffect(VFX_IMP_KNOCK);

        //First, remove all effects
        RemoveEffectOfType(oTarget1,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oTarget2,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oWrong,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oDoor1,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oDoor2,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oRelay,EFFECT_TYPE_BEAM);

        // Check the new state (rest variables first)
        int=nPlaced1 0;
        int nPlaced2 = 0;

// Erick - removed
//        SetLocalInt(oBlock1a,"nActive",1);
//        SetLocalInt(oBlock1b,"nActive",1);
//        SetLocalInt(oBlock2a,"nActive",1);
//        SetLocalInt(oBlock2b,"nActive",1);

    //
    //  States are: 0   We don't care
    //              1   Correct for statue 1
    //              2   Correct for statue 2
    //              3   Wrong, using statue 1
    //              4   Wrong, using statue 2
    //
        //Check mirror1
        if(GetIsObjectValid(oMirror1))
        {
            if (GetDistanceBetween(oMirror1,oWayRight1)<2.0)
            {
                nPlaced1 = 1;
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1, oMirror1);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam3, oRelay);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1b, oDoor1);

// Erick - replaced with block passage function
                gn_BlockPassage(oWayRight1);
//            SetLocalInt(oBlock1a,"nActive",0);
//            SetLocalInt(oBlock1b,"nActive",0);

//            DelayCommand(2.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eKnock,oDoor1));
//            DelayCommand(2.5,SetLocked(oDoor1,FALSE));
        //************Debug line**************
//        SendMessageToPC(oPC,"Mirror 1 correct 1");

            }
            else if (GetDistanceBetween(oMirror1,oWayRight2)<2.0)
            {
                nPlaced1 = 2;
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2, oMirror1);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam3, oDoor2);

// Erick - replaced with block passage function
                gn_BlockPassage(oWayRight2);
//            SetLocalInt(oBlock2a,"nActive",0);
//            SetLocalInt(oBlock2b,"nActive",0);

//            DelayCommand(2.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eKnock,oDoor2));
//            DelayCommand(2.5,SetLocked(oDoor2,FALSE));

        //************Debug line**************
//        SendMessageToPC(oPC,"Mirror 1 correct 2");
            }
        }

        //Check mirror2
        if(GetIsObjectValid(oMirror2))
        {
            if (GetDistanceBetween(oMirror2,oWayRight1)<3.0 && nPlaced1!=1) //both mirrors won't work in the same place
            {
                nPlaced2 = 1;
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1, oMirror2);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam4, oDoor1);

// Erick - replaced with block passage function
                gn_BlockPassage(oWayRight1);
//            SetLocalInt(oBlock1a,"nActive",0);
//            SetLocalInt(oBlock1b,"nActive",0);

        //************Debug line**************
//        SendMessageToPC(oPC,"Mirror 2 correct 1");

            }
            else if (GetDistanceBetween(oMirror2,oWayRight2)<3.0 && nPlaced1!=2) //both mirrors won't work in the same place
            {
                nPlaced2 = 2;
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2, oMirror2);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam4, oDoor2);

// Erick - replaced with block passage function
                gn_BlockPassage(oWayRight2);
//            SetLocalInt(oBlock2a,"nActive",0);
//            SetLocalInt(oBlock2b,"nActive",0);

        //************Debug line**************
//        SendMessageToPC(oPC,"Mirror 2 correct 2");

            }
        }

        if(GetIsObjectValid(oMirror1))
        {
            if (nPlaced1 !=1 && nPlaced1 !=2) // First mirror in wrong place
            {
            // We only check for line of sight placements if 1. We're in the wrong place and 2. The other mirror didn't use it
                if (LineOfSightObject(oMirror1,oShoot1)) // wrong place but see statue
                {
                    nPlaced1 = 3;
//                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1, oMirror1);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1w, oShoot1);

                }
                else if (LineOfSightObject(oMirror1,oShoot2)) // wrong place but see statue
                {
                    nPlaced1 = 4;
//                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2, oMirror1);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1w, oShoot2);

                }
            }
        }

        if(GetIsObjectValid(oMirror2))
        {
            if (nPlaced2 !=1 && nPlaced2 !=2) // Second mirror in wrong place
            {
            // We only check for line of sight placements if 1. We're in the wrong place and 2. The other mirror didn't use it
                if (LineOfSightObject(oMirror2,oShoot1)) // wrong place but see statue
                {
                    nPlaced2 = 3;
//                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1, oMirror2);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2w, oShoot1);
                }
                else if (LineOfSightObject(oMirror2,oShoot2)) // wrong place but see statue
                {
                    nPlaced2 = 4;
//                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2, oMirror2);
                   ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2w, oShoot2);
                }
            }
        }

        if (nPlaced1 ==0 && nPlaced2 == 0) //both mirrors wrong
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1, oTarget1);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2, oTarget2);
        }
        else if (nPlaced1!= 1 && nPlaced2!= 1)
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1, oTarget1);
        else if (nPlaced1!= 2 && nPlaced2!= 2)
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2, oTarget2);
        else if ((nPlaced1== 1 && nPlaced2== 2) || (nPlaced1== 2 && nPlaced2== 1)) //Both are now correct - open up!
        {
            DelayCommand(2.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eKnock,oDoor1));
            DelayCommand(2.5,SetLocked(oDoor1,FALSE));
            DelayCommand(2.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eKnock,oDoor2));
            DelayCommand(2.5,SetLocked(oDoor2,FALSE));
        }

        //************Debug line**************
//        SendMessageToPC(oPC,"Mirror 1 "+IntToString(nPlaced1)+" Mirror 2 "+IntToString(nPlaced2));

    }
}
