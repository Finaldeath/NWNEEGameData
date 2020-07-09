void main()
{
    object oPC = GetFirstPC();

    SignalEvent(GetObjectByTag("rb_maze_helper"),EventUserDefined(5201));

    if (GetLocalInt(oPC, "ac_kill_nonmaze")==1) return;

    SetLocalInt(oPC, "ac_kill_maze", 1);
}
