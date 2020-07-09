void main()
{
    SetLocalInt(GetModule(), "frederic", 2);
    GiveXPToCreature(GetPCSpeaker(),150);
    int iReward = GetLocalInt(GetModule(), "iFrederickReward");
    if(iReward > 0)
    {
        GiveGoldToCreature(GetPCSpeaker(), iReward);
    }
}
