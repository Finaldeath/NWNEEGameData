void main()
{
    object oPC = GetFirstPC();
    if (GetLocalInt(oPC, "ac_kill_nonmaze")==1) return;

    SetLocalInt(oPC, "ac_kill_maze", 1);
    SignalEvent(GetObjectByTag("rb_maze_helper"),EventUserDefined(5201));
    SoundObjectStop(GetObjectByTag("ac_snd_werewolf"));
    SoundObjectStop(GetObjectByTag("ac_snd_werewolf2"));
}
