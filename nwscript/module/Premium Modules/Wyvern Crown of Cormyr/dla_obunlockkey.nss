//Script for rewarding xp to the PC opening the lock.
#include "CU_FUNCTIONS"
void main()
{
    if (GetLocalInt(GetLastUnlocked(),"un"+GetTag(OBJECT_SELF))<1){
    PartyGotEntry("un"+GetTag(OBJECT_SELF),GetLastUnlocked(), 25, "XP gain - use of key/skill");}
}
