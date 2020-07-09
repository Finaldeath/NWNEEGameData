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
if (GetTag(GetArea(OBJECT_SELF))!= "C1AR0701AWealthyRuralHouse") return;
if (IsInConversation(OBJECT_SELF)) return;
if (GetLocalInt(OBJECT_SELF, "no_banter") == 1) return;
if (GetIsDead(OBJECT_SELF)) return;
object oTarget;
if (GetTag(OBJECT_SELF) == "ac_muriel")
{
oTarget = GetObjectByTag("ac_alicine");
}
else
{
oTarget = GetObjectByTag("ac_muriel");
}
SetFacingPoint(GetPosition(oTarget));
ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 5.7);
}

