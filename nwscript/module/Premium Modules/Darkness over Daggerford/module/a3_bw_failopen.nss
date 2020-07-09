//::///////////////////////////////////////////////
//::
//:: a3_bw_failopen
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: Send a message to PC about this door being barred.
//:: Message stored on object in sMessage variable - string.
//::
//:: Doors can be unbarred if blocking objects are removed.
//:: To block door: put 'block' in it's tag
//:: Also place on death script on blocking objects nearby
//:: with this tag: bw_blocker
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 9/7/2005
//::
//:://////////////////////////////////////////////

// WARNING: VARIABLES NEEDED!

void main()
{
    if (GetLocalInt(OBJECT_SELF, "nNoFeedback") == 1) return;

    object oEnterer = GetEnteringObject();
    if (GetIsPC(oEnterer))
    {
        // check to see if this door is blocked
        if (FindSubString(GetTag(OBJECT_SELF), "block") != -1)
        {
            // this door might be blocked
            object oBlocker = GetNearestObjectByTag("bw_blocker");
            float fDist = GetDistanceToObject(oBlocker);
            if ((fDist > 10.0f) && (fDist < 0.0f))
            {
                // this door is not blocked
                SetLocked(OBJECT_SELF, FALSE);
                DelayCommand(0.5, FloatingTextStringOnCreature("This door is no longer blocked!", oEnterer, TRUE));
                return;
            }
            else
            {
                // this door is blocked
                DelayCommand(0.5, FloatingTextStringOnCreature("This door is blocked by something.", oEnterer, TRUE));
                return;
            }
        }

        // otherwise deliver a specific message
        string sMessage = GetLocalString(OBJECT_SELF, "sMessage");
        if (sMessage != "")
        {
            DelayCommand(0.5, FloatingTextStringOnCreature(sMessage, oEnterer, TRUE));
        }
    }
}
