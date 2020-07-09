//on perception handler for Captain Herab
//buff using Invisibility and Death Armor potions
//Author: Damian Brown (Luspr)
//Date: 15-Aug-2005
#include "nw_i0_generic"
void main()
{
    if(GetLocalInt(OBJECT_SELF,"do_once")!=1)
    {
        SetLocalInt(OBJECT_SELF,"do_once",1);
        ClearAllActions();//trying to avoid missing the perception event
        TalentBuffSelf();
    }
    ExecuteScript("nw_c2_default2", OBJECT_SELF);
}
