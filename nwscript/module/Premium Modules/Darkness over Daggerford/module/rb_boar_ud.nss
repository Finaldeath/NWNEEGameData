#include "nw_i0_generic"

const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Heartbeat()
{
    int iAction = 0;
    string sWaypoint = "BOAR0";

    if(GetLocalInt(OBJECT_SELF, "iBusy") == 1)
    {
        return;
    }
    else
    {
        iAction = d4();
        if(iAction < 4)
        {
            string sNewWaypoint = sWaypoint + IntToString(iAction);
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "iBusy", 0));
            ActionMoveToObject(GetObjectByTag(sNewWaypoint));
            ActionMoveToObject(GetObjectByTag(sNewWaypoint));
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "iBusy", 0));
        }
        else
        {
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "iBusy", 0));
            PlaySound("c_boar_atk1");
            ActionWait(6.0);
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "iBusy", 0));
        }
    }
}

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if (nUser == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
    }
}
