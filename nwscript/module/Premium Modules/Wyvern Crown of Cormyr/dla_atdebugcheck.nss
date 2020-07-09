void main()
{
    SendMessageToPC(GetPCSpeaker(),"Plot state: "+IntToString(GetLocalInt(GetPCSpeaker(),"nMainPlot")));
}
