//::///////////////////////////////////////////////
//:: FileName ac_lever2_ou
//:: Toggle the lever; if on, open door
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////

void main()
{
    int iFirstUse = 0;
    int nUsed = GetLocalInt(OBJECT_SELF, "LEVER_STATE");
    int x = 1;

    object oHenchmanDoor = GetObjectByTag("MazeHenchmanJail");
    object oJonas = GetObjectByTag("ac_jonas1");
    object oJunior = GetObjectByTag("ac_jonas2");
    object oPettywickDoor = GetObjectByTag("maze_prison_pettywick");
    object oPC = GetLastUsedBy();
    object oP = GetObjectByTag("ac_pettywick");

    if((!GetIsDead(oJonas) && GetDistanceToObject(oJonas)> 0.0 && GetDistanceToObject(oJonas) < 10.0) ||
       (!GetIsDead(oJunior) && GetDistanceToObject(oJunior)> 0.0 && GetDistanceToObject(oJunior) < 10.0))
    {
        FloatingTextStringOnCreature("The lever is difficult to pull right now.", oPC);
        return;
    }

    if (nUsed == 1)
    {
        SetLocalInt(OBJECT_SELF, "LEVER_STATE", 0);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "LEVER_STATE", 1);
    }

    nUsed = GetLocalInt(OBJECT_SELF, "LEVER_STATE");

    if (nUsed==1)
    {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocalInt(oP, "pulled_lever", 1);
        SetLocked(oHenchmanDoor, FALSE);
        AssignCommand(oHenchmanDoor, ActionOpenDoor(oHenchmanDoor));
        SetLocked(oPettywickDoor, FALSE);
        AssignCommand(oPettywickDoor, ActionOpenDoor(oPettywickDoor));
        if(GetLocalInt(OBJECT_SELF, "iFirstUse") == 0)
        {
            SetLocalInt(OBJECT_SELF, "iFirstUse", 1);
            DelayCommand(1.5, AssignCommand(oP,ActionStartConversation(oPC)));
        }
    }
    else
    {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        AssignCommand(oHenchmanDoor, ActionCloseDoor(oHenchmanDoor));
        AssignCommand(oPettywickDoor, ActionCloseDoor(oPettywickDoor));
    }
}

