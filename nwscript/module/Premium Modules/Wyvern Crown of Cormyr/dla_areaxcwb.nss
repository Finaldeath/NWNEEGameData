/*
    DLA_AREAXCWB.nss
    OnExit for Castle Wyvernwater  - Basement
    "gaoneng" Erick            March 27, 2006

    Checks if exiting object is PC. If so, decrease pc count in area by 1.
    If PC count in area is 0, remove all beam fx temporarily. This does not
    modify the lock states, all it does is to deactivate the visual effects.
*/

#include "cu_puzzles"

void main()
{
    object oArea = OBJECT_SELF;
    if (!GetIsPC(GetExitingObject())) return;
//    int pcnum = GetLocalInt(area, "GN_PCNUM") - 1;
//    SetLocalInt(area, "GN_PCNUM", pcnum);
    int i = 0;
    object oPC = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oPC))
    {
        if (GetIsPC(oPC))
        {
            i = 1; break;
        }
        oPC = GetNextObjectInArea(oArea);
    }
    if (!i) gn_ResetBeamsToNone(oArea);
}

/*

// January 2006
// B W-Husey
// Area exit script for Wyvernwater basement. Switch off the beam puzzle.

#include "x0_i0_petrify"

void main()        // Erick sez - this need PC check, else, ANY exiting object will turn stuff off...
{
//        object oShoot1 = GetObjectByTag("CWBShooter1");
//        object oShoot2 = GetObjectByTag("CWBShooter2");

        object oTarget1 = GetObjectByTag("CWBTarget1");
        object oTarget2 = GetObjectByTag("CWBTarget2");

//        effect eBeam1 = EffectBeam(VFX_BEAM_HOLY, oShoot1, BODY_NODE_CHEST);
//        effect eBeam2 = EffectBeam(VFX_BEAM_HOLY, oShoot2, BODY_NODE_CHEST);

        RemoveEffectOfType(oTarget1,EFFECT_TYPE_BEAM);
        RemoveEffectOfType(oTarget2,EFFECT_TYPE_BEAM);

}



