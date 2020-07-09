//true if xanda has not rewarded player
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"xanda_reward")!=1)
    return TRUE;
    return FALSE;
}
