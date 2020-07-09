//::///////////////////////////////////////////////
//:: ptc_a0_pctrans
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Door script to prevent hostiles from following
    the PC into "Safe Areas" in the module.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void JumpAssociate(object oMaster, object oTarget, int iAssociateType);

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetClickingObject();
    object oTarget = GetTransitionTarget(oSelf);
    object oCursor;
    int iCounter;

    //SendMessageToPC(oPC, "**You are trying to transition.");
    //SendMessageToPC(oPC, "Door: " + GetTag(oSelf) + " Destination: " + GetTag(oTarget));

    if(GetIsPC(oPC) == TRUE)
    {
        AssignCommand(oPC, ActionJumpToObject(oTarget));
        JumpAssociate(oPC, oTarget, ASSOCIATE_TYPE_ANIMALCOMPANION);
        JumpAssociate(oPC, oTarget, ASSOCIATE_TYPE_DOMINATED);
        JumpAssociate(oPC, oTarget, ASSOCIATE_TYPE_FAMILIAR);
        JumpAssociate(oPC, oTarget, ASSOCIATE_TYPE_HENCHMAN);
        JumpAssociate(oPC, oTarget, ASSOCIATE_TYPE_SUMMONED);
    }
}

void JumpAssociate(object oMaster, object oTarget, int iAssociateType)
{
    int iCounter = 1;
    object oCursor = GetAssociate(iAssociateType, oMaster, iCounter++);

    while(GetIsObjectValid(oCursor) == TRUE)
    {
        AssignCommand(oCursor, ActionJumpToObject(oTarget));
        oCursor = GetAssociate(iAssociateType, oMaster, iCounter++);
    }
}
