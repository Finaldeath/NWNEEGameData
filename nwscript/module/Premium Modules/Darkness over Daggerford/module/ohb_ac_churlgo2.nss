//::///////////////////////////////////////////////
//:: FileName ohb_ac_churlgo2
//:: Tending cheese vats ohb
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: Feb 5, 2006 2:13:17 PM
//:://////////////////////////////////////////////
#include "NW_I0_PLOT"
void ahcFace(object oSource, object oTarget)
{
AssignCommand(oSource, SetFacingPoint(GetPosition(oTarget)));
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
if (IsInConversation(OBJECT_SELF)) return;

string sComment;
int nRandom=d4();

int x = d3();
    switch (x)
    {
    case 1:
    sComment = "Needs more stirring...";
    break;
    case 2:
    sComment = "I told Filia not to put so much salt in!";
    break;
    case 3:
    sComment = "Another few days for this one...";
    break;
    }

object owaypoint= GetLocalObject(OBJECT_SELF, "waypoint");

if (!GetIsObjectValid(owaypoint))
{
        // Randomly seek out up to the 4th-nearest cheese vat
        owaypoint=GetNearestObjectByTag("dag_vatch",OBJECT_SELF, nRandom);
        if (owaypoint != OBJECT_SELF && GetIsObjectValid(owaypoint) )
        {
        // Move to waypoint
        SetLocalInt(OBJECT_SELF, "maid_state", 1);
        SetLocalObject(OBJECT_SELF, "waypoint", owaypoint);
        ActionMoveToObject(owaypoint, FALSE, 2.0);
        ActionDoCommand(ahcFace(OBJECT_SELF, owaypoint));
//      ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 0.7);
        ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 1.4);
        if (d2() == 2)
        {
        ActionDoCommand(SpeakString(sComment));
        }
//        ActionWait(2.0);
        ActionDoCommand(SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID));
        }
}
}

