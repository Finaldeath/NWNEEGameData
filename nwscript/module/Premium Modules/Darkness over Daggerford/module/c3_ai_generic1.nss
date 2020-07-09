//Run an AI script if the right NPC enters the trigger

void main()
{
    object oNPC = GetEnteringObject();
    string sTagVar = GetLocalString(OBJECT_SELF, "sOwner");
    string sScript = GetLocalString(OBJECT_SELF, "sOnEnter");

    if(GetTag(oNPC) == sTagVar)
        ExecuteScript(sScript, OBJECT_SELF);


}
