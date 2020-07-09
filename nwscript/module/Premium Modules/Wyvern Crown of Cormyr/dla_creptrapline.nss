// November 2005
// B G P Hughes
// Wizard quick buffs and speaks a one liner.

#include "nw_i0_generic"
void main()
{
    if(GetIsPC(GetLastPerceived()) && GetIsDead(OBJECT_SELF)==FALSE)
    {
        if (GetLocalInt(OBJECT_SELF,"Buff")==0)
        {
            if(TalentAdvancedBuff(60.0))
            {
                SetLocalInt(OBJECT_SELF,"Buff",1);
            }
        }
    }

    if(!GetIsDead(OBJECT_SELF))
    {
        SpeakOneLinerConversation("trap");
    }

    ExecuteScript("nw_c2_default2", OBJECT_SELF);
}

