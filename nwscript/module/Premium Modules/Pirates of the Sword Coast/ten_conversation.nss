//::///////////////////////////////////////////////
//:: ten_conversation
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Trigger on enter fire conversation
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void InitiateConv (object oTalkto, string sConvIndex);
void ClearConv (string sConvIndex, object oTarget);

void main()
{
    object oSelf = OBJECT_SELF;
    object oTarget, oEnter, oMaster;
    string sTag = GetLocalString(oSelf, "TARGET_TAG");
    string sVar = GetLocalString(oSelf, "CONV_INDEX");
    float fDelay = 10.0f;
    int iDoOnce = GetLocalInt(oSelf, "ten_conversation");

    oEnter = GetEnteringObject();

    if ((iDoOnce == FALSE) && (GetIsPC(oEnter) == TRUE)
      && (sVar != "") && (sTag != ""))
    {
        SetLocalInt(oSelf, "ten_conversation", TRUE);

        //HAYWARD TO DO - Remove Debug
        //SendMessageToPC(oEnter, "DEBUG: ENTERED TALK TRIGGER: TARGET_TAG = '"
        //    + sTag + "' CONV_INDEX = '" + sVar + "'");

        oTarget = GetNearestObjectByTag(sTag, oEnter, 1);
        oMaster = GetMaster(oTarget);

        if (GetIsObjectValid(oTarget) == TRUE)
        {
            if (oEnter == oMaster)
            {
                AssignCommand(oTarget, InitiateConv(oMaster, sVar));
                DelayCommand(fDelay, ClearConv(sVar, oTarget));
            }
            else if ((GetArea(oEnter) == GetArea(oTarget))
                && (GetDistanceBetween(oEnter, oTarget) < 50.0f))
            {
                AssignCommand(oTarget, InitiateConv(oEnter, sVar));
                DelayCommand(fDelay, ClearConv(sVar, oTarget));
            }
        }
    }
}

void ClearConv (string sConvIndex, object oTarget)
{
    object oModule = GetModule();
    string sCurIndex = GetLocalString(oModule, "CONV_INDEX");

    if (sCurIndex == sConvIndex)
    {
        AssignCommand(oTarget, ClearAllActions());
        SetLocalString(oModule, "CONV_INDEX", "");
    }
}

void InitiateConv (object oTalkto, string sConvIndex)
{
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();

    SetLocalString(oModule, "CONV_INDEX", sConvIndex);

    ClearAllActions(TRUE);
    JumpToObject(oTalkto, FALSE);
    ActionDoCommand(AssignCommand(oTalkto, ClearAllActions(TRUE)));
    DelayCommand(0.5f, AssignCommand(oSelf, ActionStartConversation(oTalkto)));
}

