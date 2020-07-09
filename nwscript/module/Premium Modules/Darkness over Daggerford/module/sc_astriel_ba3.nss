// has the player found captain herab's desk yet?

int StartingConditional()
{
    return(GetLocalInt(GetModule(),"barge_activity") == 3);
}
