////////////////////////////////////////////////////////////////////////////////
// dla_atnotmounted - Will only display this node when the NPC is not mounted
// Scripted By Deva B. Winblood.   6/18/2006
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_horse"

int StartingConditional()
{
   object oMe=OBJECT_SELF;
   if (DLA_GetIsMounted(oMe)) return FALSE;
   return TRUE;
}
