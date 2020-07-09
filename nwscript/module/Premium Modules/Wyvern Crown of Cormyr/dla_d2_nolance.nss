//::///////////////////////////////////////////////
//:: dla_d2_nolance
//:: DLA Wyvern Crown of Cormyr
//:://////////////////////////////////////////////
/*
    Conditional script to tell us if the player has NOT selected a lance color
    yet.
*/
//:://////////////////////////////////////////////
//:: Created By: Dave Musser (Syrsnein)
//:: Created On: 31 July 2006
//:://////////////////////////////////////////////
/* Change History

 Date
 year/mm/dd | Author   | Change
 -----------+----------+--------------------------------------------------------

 */

#include "dla_i0_joust"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (!GetIsPC(oPC)) return FALSE;
    if (DLA_JoustGetLanceColor(oPC)>0) return FALSE;
    return TRUE;
}
