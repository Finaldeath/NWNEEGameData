//::///////////////////////////////////////////////
//:: FileName ohb_ac_maid
//:: Maid goes between doors on heartbeat
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/12/2005 2:13:17 PM
//:://////////////////////////////////////////////

#include "NW_I0_PLOT"

void ahcOpen(object oCabinet)
{
    AssignCommand(oCabinet, PlayAnimation(ANIMATION_PLACEABLE_OPEN));
    DelayCommand(2.5, AssignCommand(oCabinet, PlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
}

int anyPlayersInArea(object who)
{
    object pc = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, who);
    if(!GetIsObjectValid(pc))
        return 0;
    return 1;
}

void main()
{
    if(!anyPlayersInArea(OBJECT_SELF))
        return;

    if (GetLocalInt(OBJECT_SELF, "no_banter") == 1) return;
    if (IsInConversation(OBJECT_SELF)) return;

    int nRandom=d3();
    string sComment;
    string sComment2;
    switch (d6())
    {
    case 1:
    sComment = "*Knock-Knock* “I have the fine silken linens you asked for.”";
    break;
    case 2:
    sComment = "*Knock-Knock* “Here are the delectable stuffed peacock hearts you ordered.”";
    break;
    case 3:
    sComment = "*Knock-Knock* “Your frilly gown has been washed and perfumed. Shall I leave it at the door?”";
    break;
    case 4:
    sComment = "*Knock-Knock* “I have the hot oils and perfumes you requested.”";
    break;
    case 5:
    sComment = "*Knock-Knock* “Would you like some imported chocolates?”";
    break;
    case 6:
    sComment = "*Knock-Knock* “I was told you requested fresh tulips.”";
    break;
    }

    switch (d3())
    {
    case 1:
    sComment2 = "*sniff*";
    break;
    case 2:
    sComment2 = "*cough*";
    break;
    case 3:
    sComment2 = "*achoo!*";
    break;
    }

    object owaypoint= GetLocalObject(OBJECT_SELF, "waypoint");
    object oBar=GetNearestObjectByTag("wp_ac_maid_cabinet");
    object oCabinet=GetNearestObjectByTag("ac_plc_maid_cabinet");

    if (!GetIsObjectValid(owaypoint))
    {
        // Randomly seek out up to the 3rd-nearest door waypoint
        owaypoint=GetNearestObjectByTag("wp_ac_inn_door", OBJECT_SELF, nRandom);
        if (owaypoint != OBJECT_SELF && GetIsObjectValid(owaypoint) )
        {
            // Move to waypoint
            SetLocalInt(OBJECT_SELF, "maid_state", 1);
            SetLocalObject(OBJECT_SELF, "waypoint", owaypoint);
            ActionForceMoveToObject(owaypoint, FALSE, 0.0);
            ActionDoCommand(SetFacingPoint(GetPosition(owaypoint)));
            ActionSpeakString(sComment);
            ActionPlayAnimation(ANIMATION_LOOPING_PAUSE, 1.0, 1.0);
            if (d4() == 2)
            {
                ActionWait(6.0);
                ActionSpeakString(sComment2);
            }
            ActionWait(4.0);

            // Move to Cabinet
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "maid_state", 2));
            ActionForceMoveToObject(oBar, FALSE, 0.0);
            ActionDoCommand(SetFacingPoint(GetPosition(oBar)));
            if (d3() == 2)
            {
                ActionSpeakString(sComment2);
                ActionWait(1.0);
            }
            ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0);
            ActionDoCommand(ahcOpen(oCabinet));
            ActionDoCommand(SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID));
        }
    }
}

