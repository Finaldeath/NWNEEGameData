//::///////////////////////////////////////////////
//:: FileName ohb_ac_gillians
//:: Gillian's Hill puttering ohb script
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/31/2005 2:13:17 PM
//:://////////////////////////////////////////////
#include "NW_I0_PLOT"
void ahcFace(float fDir)
{
SetFacing(fDir);
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
//=============================================
object oTorch;
if(GetIsDusk() || GetIsNight())
{
    if (GetLocalString(OBJECT_SELF, "time") != "night")
    {
    oTorch = GetItemPossessedBy(OBJECT_SELF, "NW_IT_TORCH001");
    ClearAllActions();
    ActionDoCommand(ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND));
    SetLocalString(OBJECT_SELF, "time", "night");
    ActionDoCommand(SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID));
    }
}
if(GetIsDawn() || GetIsDay())
{
    if (GetLocalString(OBJECT_SELF, "time") != "day")
    {
    oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
    ClearAllActions();
    ActionDoCommand(ActionUnequipItem(oTorch));
    SetLocalString(OBJECT_SELF, "time", "day");
    ActionDoCommand(SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID));
    }
}

//=============================================

int nRandom=d4();


object owaypoint= GetLocalObject(OBJECT_SELF, "waypoint");

if (!GetIsObjectValid(owaypoint))
{
        // Randomly seek out up to the 6th-nearest waypoint
        owaypoint=GetNearestObjectByTag("wp_ac_gillianshill",OBJECT_SELF, nRandom);
        float fDir = GetLocalFloat(owaypoint, "direction");
        int iAnim = GetLocalInt(owaypoint, "animation");
        float fLen = GetLocalFloat(owaypoint, "animation_length");
        string sType = GetLocalString(owaypoint, "animation_type");
        if (owaypoint != OBJECT_SELF && GetIsObjectValid(owaypoint) )
        {
        // Move to waypoint
        SetLocalObject(OBJECT_SELF, "waypoint", owaypoint);
        ActionMoveToObject(owaypoint, FALSE, 2.0);
        ActionDoCommand(ahcFace(fDir));
        if (sType == "looping")
        {
        ActionPlayAnimation(iAnim, 1.0, fLen);
        }
        else
        {
        ActionPlayAnimation(iAnim);
        }
        ActionDoCommand(SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID));
        }
}
}

