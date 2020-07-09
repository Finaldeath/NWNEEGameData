//::///////////////////////////////////////////////
//:: FileName ohb_ac_churlgos
//:: Tasting cheese ohb
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/25/2005 2:13:17 PM
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
int nRandom=d6();

int x = d3();
    switch (x)
    {
    case 1:
    sComment = "Not quite as good as last year, I must say.";
    break;
    case 2:
    sComment = "Yuck...too much salt!";
    break;
    case 3:
    sComment = "Poor ingredients makes for poor cheese.";
    break;
    }

object owaypoint= GetLocalObject(OBJECT_SELF, "waypoint");

if (!GetIsObjectValid(owaypoint))
{
        // Randomly seek out up to the 6th-nearest table
        owaypoint=GetNearestObjectByTag("pdag_tablebest",OBJECT_SELF, nRandom);
        if (owaypoint != OBJECT_SELF && GetIsObjectValid(owaypoint) )
        {
        // Move to waypoint
        SetLocalInt(OBJECT_SELF, "maid_state", 1);
        SetLocalObject(OBJECT_SELF, "waypoint", owaypoint);
        ActionMoveToObject(owaypoint, FALSE, 2.0);
        ActionDoCommand(ahcFace(OBJECT_SELF, owaypoint));
        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 0.7);
        ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 0.7);
        if (d2() == 2)
        {
        ActionDoCommand(SpeakString(sComment));
        }
//        ActionWait(2.0);
        ActionDoCommand(SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID));
        }
}
}

