// B W-Husey
// Fire up the tracks conversation, as per the dialogue on the object, with
// animation and delay.

#include "dla_i0_horse"

void main()
{
    object oPC = GetLastUsedBy();
/*    if (DLA_GetIsMounted(oPC))   //removed as it's annoying
    {
        DLA_Dismount(oPC,TRUE);
        DelayCommand(4.0,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0)));
        DelayCommand(4.0,FloatingTextStringOnCreature("... Tracking ...", oPC));
        DelayCommand(6.1, ActionStartConversation(oPC));
    }
    else
*/
    {
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
    FloatingTextStringOnCreature("... Tracking ...", oPC);
    DelayCommand(2.1, ActionStartConversation(oPC));
    }
}
