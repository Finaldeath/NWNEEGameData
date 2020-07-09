// change the area music when the player enters a trigger

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        object oArea = GetArea(oPC);
        int nChange = GetLocalInt(OBJECT_SELF, "HF_MUSIC_CHANGE");
        int nBattle = GetLocalInt(OBJECT_SELF, "HF_MUSIC_BATTLE");
        if (nBattle != 0)
        {
            MusicBattleChange(oArea, nBattle);
            if (nChange)
                MusicBattlePlay(oArea);
        }
        int nDay = GetLocalInt(OBJECT_SELF, "HF_MUSIC_DAY");
        if (nDay != 0)
        {
            MusicBackgroundChangeDay(oArea, nDay);
            if (nChange)
                MusicBackgroundPlay(oArea);
        }
        int nNight = GetLocalInt(OBJECT_SELF, "HF_MUSIC_NIGHT");
        if (nNight != 0)
        {
            MusicBackgroundChangeNight(oArea, nNight);
            if (nChange)
                MusicBackgroundPlay(oArea);
        }
        if (GetLocalInt(OBJECT_SELF, "HF_DESTROY") != 0)
        {
            DestroyObject(OBJECT_SELF);
        }
    }
}
