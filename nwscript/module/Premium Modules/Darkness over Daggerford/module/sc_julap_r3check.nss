// did the player get julap's third riddle correct?

void Done()
{
    SetLocalInt(OBJECT_SELF, "r3c1", 0);
    SetLocalInt(OBJECT_SELF, "r3c2", 0);
    SetLocalInt(OBJECT_SELF, "r3c3", 0);
    SetLocalInt(OBJECT_SELF, "r3c4", 0);
    SetLocalInt(OBJECT_SELF, "r3c5", 0);
}

int StartingConditional()
{
    int nRight = FALSE;

    if (GetLocalInt(OBJECT_SELF, "r3c1") == 1 &&
        GetLocalInt(OBJECT_SELF, "r3c2") == 0 &&
        GetLocalInt(OBJECT_SELF, "r3c3") == 1 &&
        GetLocalInt(OBJECT_SELF, "r3c4") == 0 &&
        GetLocalInt(OBJECT_SELF, "r3c5") == 1 )
    {
        nRight = TRUE;
    }

    Done();
    return(nRight);
}
