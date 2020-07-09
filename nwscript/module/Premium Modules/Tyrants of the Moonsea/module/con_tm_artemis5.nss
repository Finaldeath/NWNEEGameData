// returns true if Astar is not in the area

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oAstar = GetNearestObjectByTag("Astar", oPC);
    return (!GetIsObjectValid(oAstar));
}
