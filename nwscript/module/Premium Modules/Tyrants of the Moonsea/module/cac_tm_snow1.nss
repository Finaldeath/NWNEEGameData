// secret: snowdrift buried zhent

void main()
{
    object oPC = GetPCSpeaker();
    object oWP = GetWaypointByTag("WP_SRE_SECRET_SNOW");
    object oZhent = CreateObject(OBJECT_TYPE_CREATURE, "buriedzhent", GetLocation(oWP));
    AssignCommand(oZhent, ActionStartConversation(oPC));
    DestroyObject(OBJECT_SELF);
}
