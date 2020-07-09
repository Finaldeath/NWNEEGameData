////////////////////////////////////////////////////////////////////////////////
// dla_ca_archex - Archery Contest Speak with Referee exit
// Original Scripter: Deva B. Winblood    6/16/2006
////////////////////////////////////////////////////////////////////////////////

void main()
{
   object oReferee=OBJECT_SELF;
   object oWP=GetWaypointByTag("WP_ARCHERY_REF_START");
   AssignCommand(oReferee,ActionMoveToObject(oWP,TRUE));
   AssignCommand(oReferee,ActionDoCommand(SetFacing(GetFacing(oWP))));
}
