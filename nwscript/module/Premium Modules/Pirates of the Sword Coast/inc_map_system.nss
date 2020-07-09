//::///////////////////////////////////////////////
//:: inc_map_system
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file for the Treasure Map system.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

// Return a Direction based on the source and target.
string GetDirection(object oSource, object oTarget);

// Handle activation of a Map Object.
void ActivateMap(object oActivator, object oActivated);

// Handle activation of a Map Object.
void ActivateMap(object oActivator, object oActivated)
{
    object oMap = OBJECT_INVALID;

    // Create the Placable for the Map conversation.
    SetLocalObject(oActivator, "PLC_CONVOBJ", oActivated);
    oMap = CreateObject(OBJECT_TYPE_PLACEABLE, "potsc_plcmp", GetLocation(oActivator));

    //SendMessageToPC(oActivator, "Running Map - "+ GetTag(oActivated));

    //AssignCommand(oActivator, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oActivator,
        ActionStartConversation(oMap, "potsc_treasure")));
}

// Return a Direction based on the source and target.
string GetDirection(object oSource, object oTarget)
{
    string sReturn = "INVLAID_LOCATION on 'GetDirection'";
    float fDirection;
    vector vAngle, vSource, vTarget;

    vSource = GetPosition(oSource);
    vTarget = GetPosition(oTarget);

    vAngle.x = vTarget.x - vSource.x;
    vAngle.y = vTarget.y - vSource.y;
    vAngle.z = 0.0f;

    fDirection = VectorToAngle(vAngle);

    if ((fDirection > 67.5f) && (fDirection < 112.5f))
    {
        sReturn = "North";
    }
    else if ((fDirection > 112.5f) && (fDirection < 157.5f))
    {
        sReturn = "North West";
    }
    else if ((fDirection > 157.5f) && (fDirection < 202.5f))
    {
        sReturn = "West";
    }
    else if ((fDirection > 202.5f) && (fDirection < 247.5f))
    {
        sReturn = "South West";
    }
    else if ((fDirection > 247.5f) && (fDirection < 292.5f))
    {
        sReturn = "South";
    }
    else if ((fDirection > 292.5f) && (fDirection < 337.5f))
    {
        sReturn = "South East";
    }
    else if ((fDirection > 337.5f) || (fDirection < 22.5f))
    {
        sReturn = "East";
    }
    else if ((fDirection > 22.5f) && (fDirection < 67.5f))
    {
        sReturn = "North East";
    }

    return sReturn;
}
