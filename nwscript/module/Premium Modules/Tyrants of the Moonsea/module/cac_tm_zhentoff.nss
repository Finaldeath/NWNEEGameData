//Award xp when Merrik and Zhent Officer are alive after Iyrauroth battle
void main()
{
    if(GetLocalInt(OBJECT_SELF, "nXPAwarded") == 0)
    {
        GiveXPToCreature(GetFirstPC(), 250);
        SetLocalInt(OBJECT_SELF, "nXPAwarded", 1);
    }
}
