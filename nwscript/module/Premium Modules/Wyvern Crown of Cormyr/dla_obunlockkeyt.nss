//Script for rewarding xp to the PC opening the lock. This script disarms the trap on unlocking.
#include "CU_FUNCTIONS"
void main()
{
    SetTrapDisabled(OBJECT_SELF);
    int nOnce = GetLocalInt(GetLastUnlocked(), "un"+GetTag(OBJECT_SELF)); // check to see if unlocked by this PC before (uses "un" to distinguish from disarm variable)
    if (nOnce==FALSE) //If not unlocked before by PC
    {
    GiveXPToCreature (GetLastUnlocked(), 50); // Reward PC, alternatively, if you wish to reward party use PartyGotEntry() and Include cu_functions as with Multiplayer Experience Scripts 2
    FloatingTextStringOnCreature("XP Gained - use of skill/key. Trap on lock disabled.",GetLastUnlocked()); // Tell the PC you gave him xp
    AllParty("un"+GetTag(OBJECT_SELF),GetLastUnlocked(),TRUE);  //Set so no one else in the party (and the opener) can get this xp again.
    }
}
