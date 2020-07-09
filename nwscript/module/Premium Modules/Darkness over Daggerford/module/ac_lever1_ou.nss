//::///////////////////////////////////////////////
//:: FileName ac_lever2_ou
//:: Toggle the lever; if on, open door
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////

void main()
{
    int nUsed=GetLocalInt(OBJECT_SELF, "LEVER_STATE");
    object oD = GetObjectByTag("ac_dr_maze_pc");

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
        SetLocked(oD, FALSE);
        AssignCommand(oD, ActionOpenDoor(oD));
    }
    else
    {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        AssignCommand(oD, ActionCloseDoor(oD));
    }
}

