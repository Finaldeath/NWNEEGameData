//actions to take when the harpers accompany PC to Teygans's cave
void main()
{
    object oPC = GetEnteringObject();
    location lLetter = GetLocation(GetWaypointByTag("wp_teygan_letter"));
    if(GetLocalInt(GetModule(), "teygan_start") ==3)
    {
        if(GetLocalInt(OBJECT_SELF, "letter") !=1)
        {
            CreateObject(OBJECT_TYPE_ITEM, "db_teyganletter", lLetter);
            SetLocalInt(OBJECT_SELF, "letter", 1);
        }
    }
    if(GetIsPC(oPC)&&!GetLocalInt(OBJECT_SELF,"harpers_here")==1)
    {
        object oDrelia = GetObjectByTag("db_drelia");
        AssignCommand(oDrelia,ActionStartConversation(oPC));
        SetLocalInt(OBJECT_SELF,"harpers_here",1);
    }
}
