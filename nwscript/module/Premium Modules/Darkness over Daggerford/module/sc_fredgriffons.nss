//true if player is working on the teygan bandit quest
int StartingConditional()
{
    if(!(GetLocalInt(OBJECT_SELF, "do_once_fred") != 1))
    return FALSE;

    if(GetLocalInt(GetModule(),"teygan_bandits")!=1)
    return FALSE;

    return TRUE;

}
