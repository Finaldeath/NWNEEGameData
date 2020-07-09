#include "NW_I0_GENERIC"

void CheckFight();

void main()
{
    string sTag = GetTag(OBJECT_SELF);
    if (sTag == "bw_ogre03") // bridgekeeper
    {
        DelayCommand(2.5f, CheckFight());
    }
    else WalkWayPoints();
}

void CheckFight()
{
    object oEnemy = GetLocalObject(OBJECT_SELF, "oEnemy");
    if (!GetIsObjectValid(oEnemy) || (!GetObjectSeen(oEnemy)))
    {
        if (!GetIsInCombat())
        {
            object oWP = GetNearestObjectByTag("WP_bw_ogre03_ret");
            ActionMoveToObject(oWP);
        }
    }
}
