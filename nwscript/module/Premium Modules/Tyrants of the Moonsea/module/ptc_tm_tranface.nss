//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ptc_tm_tranface
// DATE: October 15, 2018.
// AUTH: Rich Barker
// NOTE: Set Camera Facing to fTransitionFacing on area transition click
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oClicker=GetClickingObject();
    object oTarget=GetTransitionTarget(OBJECT_SELF);

    float fFacing = GetLocalFloat(OBJECT_SELF, "fTransitionFacing");

    // move all party members
    object oParty = GetFirstFactionMember(oClicker, TRUE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oClicker))
    {
        AssignCommand(oParty, JumpToObject(oTarget));
        oParty = GetNextFactionMember(oClicker, TRUE);
    }

    // move all non-party members such as familiars
    oParty = GetFirstFactionMember(oClicker, FALSE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oClicker))
    {
        AssignCommand(oParty, JumpToObject(oTarget));
        oParty = GetNextFactionMember(oClicker, FALSE);
    }

     // move the player
    AssignCommand(oClicker, JumpToObject(oTarget));
    AssignCommand(oClicker, SetCameraFacing(fFacing));
}
