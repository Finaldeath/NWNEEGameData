//::///////////////////////////////////////////////
//:: dla_jst_lancerak
//:: DLA Wyvern Crown of Cormyr
//:://////////////////////////////////////////////
/*
    Select lances for the player and the opponent
*/
//:://////////////////////////////////////////////
//:: Created By: Dave Musser (Syrsnein)
//:: Created On: 12 July 2006
//:://////////////////////////////////////////////
/* Change History

 Date
 year/mm/dd | Author   | Change
 -----------+----------+--------------------------------------------------------

 */

#include "dla_i0_joust"

int DLA_GetRackHasLance(object oLanceRack, int nLance)
{
    string sLance = IntToString(nLance);
    return !GetLocalInt(oLanceRack, "dla_lance_used"+sLance);
}

void DLA_RemoveFromLanceRack(object oLanceRack, int nLance)
{
    int nAnim = 0;
    switch(nLance)
    {
        case DLA_LANCE_YELLOW: nAnim = ANIMATION_LANCERACK_REM_YELLOW; break;
        case DLA_LANCE_BLUE  : nAnim = ANIMATION_LANCERACK_REM_BLUE;   break;
        case DLA_LANCE_BLACK : nAnim = ANIMATION_LANCERACK_REM_BLACK;  break;
        case DLA_LANCE_BARE  : nAnim = ANIMATION_LANCERACK_REM_BARE;   break;
    }
    SetLocalInt(oLanceRack, "dla_lances_used", GetLocalInt(oLanceRack, "dla_lances_used")+1);
    SetLocalInt(oLanceRack, "dla_lance_used"+IntToString(nLance), TRUE);
    AssignCommand(oLanceRack, ActionPlayAnimation(nAnim));
}

void DLA_JoustEquipLance(object oPC, int nLance)
{
    object oLance = CreateItemOnObject(DLA_TAG_JOUST_LANCE+IntToString(nLance), oPC);
    SetLocalObject(oPC, DLA_VAR_JOUST_LANCE, oLance);
    //force equip lance
    DelayCommand(0.1, AssignCommand(oPC, ActionEquipItem(oLance, INVENTORY_SLOT_RIGHTHAND)));
}

void DLA_JoustSelectLance(object oPC, int nLance)
{
// Yellow = 1 = Activate
// Blue   = 2 = Open
// Black  = 3 = Close
// Bare   = 4 = DeActivate
    float fCueTime = 0.0;
    object oLanceRack = GetObjectByTag(DLA_TAG_JOUST_LANCERACK);
    if (!GetIsPC(oPC))
    {
        int nLanceOpp = d4();
        if (nLance==DLA_LANCE_YELLOW && DLA_GetRackHasLance(oLanceRack, DLA_LANCE_BARE))
            nLanceOpp = DLA_LANCE_BARE;
        else if (nLance==DLA_LANCE_BLUE && DLA_GetRackHasLance(oLanceRack, DLA_LANCE_BLACK))
            nLanceOpp = DLA_LANCE_BLACK;
        else while (!DLA_GetRackHasLance(oLanceRack, nLanceOpp))
        {
            nLanceOpp = d4();
        }
        nLance = nLanceOpp;
    }

    DelayCommand(fCueTime+=0.2, AssignCommand(oPC, ActionMoveToObject(oLanceRack)));
    DelayCommand(fCueTime+=0.8, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0, 1.0)));
    DelayCommand(fCueTime+=0.8, DLA_RemoveFromLanceRack(oLanceRack, nLance));
    DelayCommand(fCueTime+=0.01, DLA_JoustEquipLance(oPC, nLance));
}

void main()
{
    object oPC = OBJECT_SELF;
    float fCueTime = 0.0;
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);

    if (!GetCutsceneMode(oPC))
    {
        SetCutsceneMode(oPC);
    }
    int bTraining = DLA_GetIsOnTraining(oPC);
    int nLance = bTraining ? 4 : DLA_JoustGetLanceColor(oPC);
    if (nLance < 1) nLance = 4;

    // Have oPC get the lance from the rack
    DelayCommand(fCueTime+=0.1, DLA_JoustSelectLance(oPC, nLance));
    // Get the lance for the opponent unless the opponent is Jonas
    if (DLA_GetOpponentNumber(oPC) != DLA_JOUST_OPPONENT_JONAS)
    {
        DelayCommand(fCueTime+=1.9, DLA_JoustSelectLance(oOP, nLance));
    }
    DelayCommand(fCueTime+=2.5, DLA_ChangeToJoustingPheno(oPC));
    DelayCommand(fCueTime+=0.1, DLA_ChangeToJoustingPheno(oOP));
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_ENTER")))));
    DelayCommand(fCueTime+=0.1, AssignCommand(oOP, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_ENTER")))));
//    DelayCommand(fCueTime+0.1, SetCutsceneMode(oPC, FALSE));
    DelayCommand(fCueTime+=5.0, ExecuteScript("dla_jst_resetrak", GetNearestObjectByTag("dla_lancerack")));
}
