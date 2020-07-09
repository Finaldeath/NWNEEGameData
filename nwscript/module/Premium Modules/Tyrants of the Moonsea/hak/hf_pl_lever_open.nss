// using a lever opens or closes a nearby door
//
//   HF_DOOR_TAG - tag of the door to open/close
//   HF_REPEATING - set to 1 if the lever can be pulled more than once
//   HF_OPEN_SOUND - sound of door opening
//   HF_CLOSE_SOUND - sound of door closing
//   HF_OPEN_MESSAGE - display this floaty text when opening
//   HF_CLOSE_MESSAGE - display this floaty text when closing
//   HF_DONE_MESSAGE - display this floaty text when already used

int PullLever(object oLever)
{
    if (GetLocalInt(OBJECT_SELF, "nState") == 0)
    {
        PlaySound("as_sw_lever1");
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE, 1.0, 1.0);
        SetLocalInt(OBJECT_SELF, "nState", 1);
        return TRUE;
    }
    else
    {
        PlaySound("as_sw_lever1");
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE, 1.0, 1.0);
        SetLocalInt(OBJECT_SELF, "nState", 0);
        return FALSE;
    }
}

void main()
{
    object oPC = GetLastUsedBy();
    if (GetIsPC(oPC))
    {
        // exit if this is a single use lever
        if (GetLocalInt(OBJECT_SELF, "nState") < 0)
        {
            string sMsg = GetLocalString(OBJECT_SELF, "HF_DONE_MESSAGE");
            if (sMsg == "")
                sMsg = "Nothing happens";
            FloatingTextStringOnCreature(sMsg, oPC);
            return;
        }

        // locate the door that we control and open or close it
        string sDoorTag = GetLocalString(OBJECT_SELF, "HF_DOOR_TAG");
        object oDoor = GetObjectByTag(sDoorTag);
        if (GetIsObjectValid(oDoor))
        {
            if (PullLever(OBJECT_SELF))
            {
                string sSound = GetLocalString(OBJECT_SELF, "HF_OPEN_SOUND");
                if (sSound != "")
                    DelayCommand(1.0f, PlaySound(sSound));
                string sMsg = GetLocalString(OBJECT_SELF, "HF_OPEN_MESSAGE");
                if (sMsg != "")
                    DelayCommand(1.1f, FloatingTextStringOnCreature(sMsg, oPC));
                DelayCommand(1.2f, ActionOpenDoor(oDoor));
                SetLocked(oDoor, FALSE);
            }
            else
            {
                string sSound = GetLocalString(OBJECT_SELF, "HF_CLOSE_SOUND");
                if (sSound != "")
                    DelayCommand(1.0f, PlaySound(sSound));
                string sMsg = GetLocalString(OBJECT_SELF, "HF_CLOSE_MESSAGE");
                if (sMsg != "")
                    DelayCommand(1.1f, FloatingTextStringOnCreature(sMsg, oPC));
                DelayCommand(1.2f, ActionCloseDoor(oDoor));
            }

            // head for the error state if we are done
            if (GetLocalInt(OBJECT_SELF, "HF_REPEATING") <= 0)
            {
                SetLocalInt(OBJECT_SELF, "nState", -1);
            }
        }
    }
}
