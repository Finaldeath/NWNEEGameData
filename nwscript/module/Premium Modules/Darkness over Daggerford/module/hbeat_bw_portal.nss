// on heartbeat

void main()
{
    int nBeats = GetLocalInt(OBJECT_SELF, "nBeats");

    if (nBeats > (6 - (d3() - 1)))
    {
        nBeats = 0;

        SignalEvent(OBJECT_SELF, EventUserDefined(501)); // summon baddy
    }
    else
    {
        nBeats += 1;
    }

    SetLocalInt(OBJECT_SELF, "nBeats", nBeats);
}
