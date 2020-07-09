// B W-Husey
// Amalgamation of Bioware scripts to deal with henchmen hire.
// Modified to include DLA horse functionality.
// Modified by Deva B. Winblood  7/29/2006 - Lacinda Horse functionality
// Modified BGPHughes 1/8/07 to remove any plot flags

#include "x0_i0_henchman"
#include "dla_i0_lacinda"
#include "x0_inc_henai"



void main()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;
    object oHorse;
    SetLocalInt(oHench, "X0_L_LEVELRULES",0);
    DLA_SetHenchman(oHench, GetPCSpeaker());   //switched from HireHenchman for multi hench - check this
    LacDebug("dla_athenchjoin(NAME:"+GetName(oHench)+", TAG:"+GetTag(oHench)+")");
    if (GetTag(oHench)=="Lacinda")
    { // untie horse
        LacDebug("  Henchman is Lacinda...deal with her horse");
        oHorse=GetObjectByTag("LacHorse");
        if (GetIsObjectValid(oHorse))
        { // valid
            LacDebug("  LacHorse exists");
            DLA_SetIsTied(oHorse,FALSE);
            DelayCommand(1.0,DLA_GiveLacindasHorse(oPC));
        } // valid
        else
        { // create the horse
            LacDebug("   LacHorse not found");
            //DLA_privateCreateLacindasHorse(oHench);

        } // create the horse
     } // untie horse
     //add some of the functions needed from HireHench()=========
     SetDidQuit(oPC, oHench, FALSE);

     // If we're hooking back up with the henchman after s/he
     //  died, clear that.
     SetDidDie(FALSE, oHench);
     SetKilled(oPC, oHench, FALSE);
     SetResurrected(oPC, oHench, FALSE);
     SetPlotFlag(oHench,FALSE);

     // Turn on standard henchman listening patterns
     SetAssociateListenPatterns(oHench);
//============================================================
     LevelUpXP1Henchman(oPC);
     DLA_RefreshMovementSpeed(oHench);
}







