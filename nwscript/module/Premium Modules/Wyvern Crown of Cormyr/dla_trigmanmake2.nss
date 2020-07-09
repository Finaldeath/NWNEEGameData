// October 2005
// B W-Husey
// If a picket enters the trigger, creates a sentry on alert in the next area who will go for the gong.
// This is controlled by the varaible set by this trigger on this PC and tested for in the area enter script
// of Polter's Fort.

void main()
{
    object oHob = GetEnteringObject();
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
    if (GetTag(oHob) == "Picket" && GetLocalInt(OBJECT_SELF,"nOnce")==0) // a picket entered the trigger
    {
        AssignCommand(oHob,SpeakOneLinerConversation("intruders2"));
        SetLocalInt(oPC,"nPFAlarmed",1);
        SetLocalInt(OBJECT_SELF,"nOnce",1);
        DestroyObject(OBJECT_SELF,6.0);
    }
}
