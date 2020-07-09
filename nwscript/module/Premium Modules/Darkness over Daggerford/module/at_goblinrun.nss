//despawn handler for goblins who don't run their on perceive properly
void RunAway();
void main()
{
    ClearAllActions();
    SetLocalInt(OBJECT_SELF, "is_busy",1);
    RunAway();
}
void RunAway()//goblins flee
//done this way to allow a choice of multiple exits
//otherwise works exactly like ActivateFleeToExit()
{
    object oExitWay = GetNearestObjectByTag("EXIT_" + GetTag(OBJECT_SELF));
    ActionMoveToObject(oExitWay, TRUE);
    ActionDoCommand(DestroyObject(OBJECT_SELF, 1.0));
}
