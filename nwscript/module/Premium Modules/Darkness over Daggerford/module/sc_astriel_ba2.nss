//true if the player is halfway through the strange cargos quest
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"barge_activity") == 2
    //check that the player has not alreasy talked about the mariner's alliance
    && !GetLocalInt(GetModule(), "astriel_barracuda_talked") ==1)
    return TRUE;
    return FALSE;
}
