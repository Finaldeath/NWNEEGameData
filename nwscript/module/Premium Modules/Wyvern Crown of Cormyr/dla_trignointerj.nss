////////////////////////////////////////////////////////////////////////////////
// dla_trignointerj - Trigger - Remove interjections from NPC
// Original Scripter: Deva B. Winblood
// Last Modified By:  Deva B. Winblood  5/5/2006
////////////////////////////////////////////////////////////////////////////////
#include "x0_i0_henchman"

void main()
{
    object oNPC=GetEnteringObject();
    if (!GetIsPC(oNPC))
    { // NPC
      SetInterjection(GetFirstPC(),0,oNPC);
    } // NPC
}
