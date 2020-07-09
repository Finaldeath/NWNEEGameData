//50% chance of success on 1st stakeout, and 100% chance on the 2nd attempt
int StartingConditional()
{
    if(d2()==1||GetLocalInt(GetModule(),"orc_stake_out")==1)
    return TRUE;
    return FALSE;
}
