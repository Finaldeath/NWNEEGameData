//::///////////////////////////////////////////////
//:: dla_jst_resetrak
//:: DLA Wyvern Crown of Cormyr
//:://////////////////////////////////////////////
/*
    Reset the lance rack visually.
*/
//:://////////////////////////////////////////////
//:: Created By: Dave Musser (Syrsnein)
//:: Created On: 12 July 2006
//:://////////////////////////////////////////////
/* Change History

 Date
 year/mm/dd | Author   | Change
 -----------+----------+--------------------------------------------------------

 */

#include "dla_i0_joust"

void main()
{
    object oLanceRack = OBJECT_SELF;
    int i;
    for (i=1;i<5;i++)
    {
        DeleteLocalInt(oLanceRack, "dla_lance_used"+IntToString(i));
    }
    DeleteLocalInt(oLanceRack, "dla_lances_used");
    DelayCommand(10.0, AssignCommand(oLanceRack, ActionPlayAnimation(ANIMATION_LANCERACK_FULL)));
}
