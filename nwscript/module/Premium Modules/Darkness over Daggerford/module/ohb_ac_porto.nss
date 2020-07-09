//::///////////////////////////////////////////////
//:: FileName ohb_ac_porto
//:: Porto bored and irritable on heartbeat
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/25/2005 2:13:17 PM
//:://////////////////////////////////////////////
#include "NW_I0_PLOT"
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
if (GetLocalInt(OBJECT_SELF, "no_hb") == 1) return;
if (IsInConversation(OBJECT_SELF)) return;
object oTorch;
if(GetIsDusk() || GetIsNight())
{
    if (GetLocalString(OBJECT_SELF, "time") != "night")
    {
    oTorch = GetItemPossessedBy(OBJECT_SELF, "NW_IT_TORCH001");
    ClearAllActions();
    ActionDoCommand(ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND));
    SetLocalString(OBJECT_SELF, "time", "night");
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
    }
}

int nRandom=d3();
string sComment;

switch (d3())
{
case 1:
sComment = "Hmmmphhh!";
break;
case 2:
sComment = "Soooo boring...";
break;
case 3:
sComment = "*Grumble*";
break;
}

switch (nRandom)
{
case 1:
if (d4() == 1)
{
SpeakString(sComment);
}
ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED);
break;
case 2:
if (d4() == 1)
{
SpeakString(sComment);
}
ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 5.5);
break;
case 3:
if (d4() == 1)
{
SpeakString(sComment);
}
break;
}


}

