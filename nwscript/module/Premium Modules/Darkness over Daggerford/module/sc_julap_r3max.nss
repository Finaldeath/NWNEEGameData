// player has named 4 suspects; this is the max

int StartingConditional()
{
    int n = 0;
    n += GetLocalInt(OBJECT_SELF, "r3c1");
    n += GetLocalInt(OBJECT_SELF, "r3c2");
    n += GetLocalInt(OBJECT_SELF, "r3c3");
    n += GetLocalInt(OBJECT_SELF, "r3c4");
    n += GetLocalInt(OBJECT_SELF, "r3c5");
    return(n >= 4);
}
