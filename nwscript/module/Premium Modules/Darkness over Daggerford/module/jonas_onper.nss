#include "rb_include"

void main()
{
    object oPerceived = GetLastPerceived();
    if(GetLocalInt(OBJECT_SELF, "iAttackShout") == 0)
    {
        if(GetIsPC(oPerceived) && GetLastPerceptionSeen() &&
           GetLocalInt(GetModule(),"iChaseStarted") == 1)
        {
            SetLocalInt(OBJECT_SELF, "iAttackShout", 1);
            SetFacingPoint(GetPosition(oPerceived));
            if(GetLocalInt(GetModule(), "iJuniorDead") == 1)
            {
                SpeakString("You will pay for my son's death!");
            }
            else
            {
                SpeakString("Looks like I'll have to help unwrap the present!");
                DelayCommand(1.5,
                    AssignCommand(GetObjectByTag("ac_jonas2"), DetermineCombatRound(oPerceived)));
            }

            ChangeToWerewolf(OBJECT_SELF, oPerceived);
        }
    }
    else
    {
        ExecuteScript("nw_c2_default2", OBJECT_SELF);
    }
}
