//::///////////////////////////////////////////////
//:: dla_obunlockxp
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   This script rewards the PC for unlocking a door/placeable
   based on the difficulty of the lock - not to be used on doors with keys.
*/
//:://////////////////////////////////////////////
//:: Created By: Ben W-Husey (B G P Hughes)
//:: Created On: June 2003
//:://////////////////////////////////////////////

// Include cu_functions for AllParty to work  (prevents multiple characters getting the same xp in the same party)
#include "CU_FUNCTIONS"

void main()
{
    object oDoor = OBJECT_SELF;
    //Set variable sLockName to object's tag
    string sLockName = "un"+GetTag(oDoor);

    //Check to see if PC has unlocked this door before
    int nOnce = GetLocalInt(GetLastUnlocked(), sLockName);
    if (nOnce==FALSE) //If not given XP before for unlocking this Lock
    {
        int nLockXPGain = GetLockUnlockDC(oDoor)*2;  //Give xp equal to unlock DC x2 (set as you like)
        object oPC = GetLastUnlocked();  // oPC is the unlocking PC
        if (nLockXPGain < 0)             // Make sure minimum xp given is 10
            {nLockXPGain = 10;}
        GiveXPToCreature (GetLastUnlocked(), nLockXPGain); // Give XP (nLockXPGain) to unlocking PC.
        FloatingTextStringOnCreature("XP Gained - use of skill",GetLastUnlocked(),FALSE); //Inform PC of XP for use of skill. Don't inform party (we don't want message on henchies)
        AllParty(sLockName,oPC,1);  //Set so no one else in the party (and the opener) can get this xp again.
    }
}
