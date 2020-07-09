//::///////////////////////////////////////////////
//:: FileName ohb_ac_gravia
//:: Gravia does random stuff on heartbeat
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/10/2005 2:13:17 PM
//:://////////////////////////////////////////////
#include "NW_I0_PLOT"
void ahcFace(float f1)
{
SetFacing(f1);
}

int anyPlayersInArea( object who )
{
    object pc = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, who );
    if( !GetIsObjectValid(pc) )
        return 0;
    return 1;
}
void main()
{
    if( !anyPlayersInArea( OBJECT_SELF ) )
        return;
    if (GetLocalInt(OBJECT_SELF, "no_banter") == 1)// return;
    {
        ExecuteScript("nw_c2_default1", OBJECT_SELF);
        return;
    }
    if (IsInConversation(OBJECT_SELF)) return;

    int nUser=GetUserDefinedEventNumber();
    int nRandom=d3();
    object owaypoint= GetLocalObject(OBJECT_SELF, "waypoint");


    if (!GetIsObjectValid(owaypoint))
    {
        // Randomly seek out up to the 3rd-nearest door waypoint
        owaypoint=GetNearestObjectByTag("wp_ac_graviahb",OBJECT_SELF, nRandom);
        if (owaypoint != OBJECT_SELF && GetIsObjectValid(owaypoint) )
        {
            // Move to waypoint
            SetLocalObject(OBJECT_SELF, "waypoint", owaypoint);
            ActionForceMoveToObject(owaypoint);
            ActionDoCommand(ahcFace(GetLocalFloat(owaypoint, "direction")));
            ActionPlayAnimation(GetLocalInt(owaypoint, "anim"), 1.0, GetLocalFloat(owaypoint, "time"));
            ActionDoCommand(SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID));

        }
    }
}

