void main()
{
    object oChest = GetLastDisturbed();

    if (!GetIsObjectValid(oChest))
        oChest = GetLastKiller();

    SetCommandable(TRUE);
    SetLocalObject(OBJECT_SELF, "HF_THIEF", oChest);
    SpeakString("HF_SHOUT_LOOT", TALKVOLUME_SILENT_SHOUT);
}
