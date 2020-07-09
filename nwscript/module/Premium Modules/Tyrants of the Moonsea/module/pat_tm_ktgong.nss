//Gong is struck by orc in training pits and alerts any barracks guards
void main()
{
    int i = 1;

    object oGongSound = GetNearestObjectByTag("KTGongRings");

    DelayCommand(0.5, SoundObjectPlay(oGongSound));
    DelayCommand(4.0, SoundObjectStop(oGongSound));

    if(GetLocalInt(OBJECT_SELF, "nUsed") == 0)
    {
        object oOrc = GetNearestObjectByTag("KTBarracks", OBJECT_SELF, i);

        while(oOrc != OBJECT_INVALID)
        {
            SignalEvent(oOrc, EventUserDefined(5000));
            i++;
            oOrc = GetNearestObjectByTag("KTBarracks", OBJECT_SELF, i);
        }

        SetLocalInt(OBJECT_SELF, "nUsed", 1);
    }
}
