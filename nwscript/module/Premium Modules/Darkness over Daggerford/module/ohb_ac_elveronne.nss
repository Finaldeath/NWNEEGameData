//::///////////////////////////////////////////////
//:: FileName ohb_ac_sisters
//:: Sisters "talk" to each other when downstairs
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/12/2005 2:13:17 PM
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
if (IsInConversation(OBJECT_SELF)) return;
if (GetIsInCombat(OBJECT_SELF)) return;
if (GetLocalInt(OBJECT_SELF,"no_banter")==1) return;
int x = d6();
int y = d4();
object oWP;
switch (x)
{
case 1:
PlaySound("c_zombie_slct");
ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
oWP = GetNearestObjectByTag("wp_ac_zombie",OBJECT_SELF, y);
ActionForceMoveToObject(oWP);
break;
case 2:
PlaySound("c_zombie_bat2");
ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
oWP = GetNearestObjectByTag("wp_ac_zombie",OBJECT_SELF, y);
ActionForceMoveToObject(oWP);
break;
case 3:
PlaySound("c_zombie_bat1");
ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
oWP = GetNearestObjectByTag("wp_ac_zombie",OBJECT_SELF, y);
ActionForceMoveToObject(oWP);
break;
case 4:
PlaySound("c_zombtyr_bat1");
ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
oWP = GetNearestObjectByTag("wp_ac_zombie",OBJECT_SELF, y);
ActionForceMoveToObject(oWP);
break;
case 5:
oWP = GetNearestObjectByTag("wp_ac_zombie",OBJECT_SELF, y);
ActionForceMoveToObject(oWP);
break;
case 6:
ClearAllActions();
break;
}
}

