//::///////////////////////////////////////////////
//:: dla_atlance4
//:: DLA Wyvern Crown of Cormyr
//:://////////////////////////////////////////////
/*
    action script for lance selection (1st lance)
*/
//:://////////////////////////////////////////////
//:: Created By: Dave Musser (Syrsnein)
//:: Created On: 2 March 2006
//:://////////////////////////////////////////////
/* Change History

 Date
 year/mm/dd | Author   | Change
 -----------+----------+--------------------------------------------------------
 2006/07/31  Syrsnein    No longer running dla_jst_lancerak from this script
                          with different method of lance color selection.
 */

#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    DLA_JoustSetLanceColor(oPC, 4);
//    DelayCommand(0.1, ExecuteScript("dla_jst_lancerak", oPC));
}
