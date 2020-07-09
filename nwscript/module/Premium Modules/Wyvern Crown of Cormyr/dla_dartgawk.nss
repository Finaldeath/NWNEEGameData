//returns true if the PC is currently playing darts.
int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(GetPCSpeaker(),"nPlayingDarts")>0;
    return iResult;
}
