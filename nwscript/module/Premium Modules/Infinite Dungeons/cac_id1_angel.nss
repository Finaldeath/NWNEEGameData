void main()
{
    // transport player back to start
    location lStart = GetStartingLocation();

    AssignCommand(GetPCSpeaker(), JumpToLocation(lStart));
}
