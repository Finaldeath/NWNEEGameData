//dla_dart_movehen
// Robert Faber, June 9, 2006
// moves henchmen out of the way of darts and sets them to stand ground

#include "X0_INC_HENAI"
void main()
{
    location lHench = GetLocation(GetWaypointByTag("WP_dartmove"));
    ClearAllActions();
    SetIsFollower(OBJECT_SELF,FALSE);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE);
    ActionForceMoveToLocation(lHench);
    ActionDoCommand(SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE));
    SendMessageToPC(GetFirstPC(),GetName(OBJECT_SELF)+ "standing ground");
}
