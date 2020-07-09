// place this script in the fail to open event

void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        // turn the player to face the object
        vector vPos = GetPosition(OBJECT_SELF);
        AssignCommand(oPC, ActionDoCommand(SetFacingPoint(vPos)));

        // see if we have a custom message to display
        string s = GetLocalString(OBJECT_SELF, "HF_LOCKED_TEXT");
        if (s != "")
        {
            SpeakString(s);
            return;
        }

        // see if we should examine ourself instead
        int nExamine = GetLocalInt(OBJECT_SELF, "HF_LOCKED_EXAMINE");
        if (nExamine > 0)
        {
            object oSelf = OBJECT_SELF;
            AssignCommand(oPC, ActionExamine(oSelf));
            return;
        }

        // no custom messages, so use our assigned dialog instead
         SpeakOneLinerConversation(s, oPC);
    }
}
