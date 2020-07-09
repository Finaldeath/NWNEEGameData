//Run an AI script if the right NPC exits the trigger

void main()
{
    object oNPC = GetExitingObject();
    string sTagVar = GetLocalString(OBJECT_SELF, "sOwner");
    string sScript = GetLocalString(OBJECT_SELF, "sOnExit");

    if(GetTag(oNPC) == sTagVar)
        ExecuteScript(sScript, OBJECT_SELF);

}
