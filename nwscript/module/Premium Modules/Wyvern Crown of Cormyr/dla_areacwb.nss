/*
    DLA_AREACWB.nss
    OnEnter for Castle Wyvernwater  - Basement
    "gaoneng" Erick            March 27, 2006

    Checks if entering object is PC. If so, increase pc count in area by 1.
    Loops through area and record objects for later use.
*/

#include "cu_puzzles"

void main()
{
    object self = OBJECT_SELF;
    if (!GetIsPC(GetEnteringObject())) return;
//    SetLocalInt(self, "GN_PCNUM", GetLocalInt(self, "PCNUM") + 1);


    if (GetLocalInt(self, "GN_CWBSETUP"))
    {
        gn_CWBMirrorCheck();
    }
    else
    {
        SetLocalInt(self, "GN_CWBSETUP", TRUE);
        gn_CWBSetupArea();
    }
}


/*
// January 2006
// B W-Husey
// Area enter script for Wyvernwater basement. Sets up the beam puzzle.

#include "cu_puzzles"

void main()
{

        object oPC = GetEnteringObject();
        MirrorCheck(oPC);

//        object oShoot1 = GetObjectByTag("CWBShooter1");
//        object oShoot2 = GetObjectByTag("CWBShooter2");

//        object oTarget1 = GetObjectByTag("CWBTarget1");
//        object oTarget2 = GetObjectByTag("CWBTarget2");

//        effect eBeam1 = EffectBeam(VFX_BEAM_SILENT_HOLY, oShoot1, BODY_NODE_CHEST);
//        effect eBeam2 = EffectBeam(VFX_BEAM_SILENT_HOLY, oShoot2, BODY_NODE_CHEST);

//        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam1, oTarget1);
//        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2, oTarget2);

}
