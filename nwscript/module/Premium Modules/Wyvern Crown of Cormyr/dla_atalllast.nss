// June 2003
// B W-Husey
// Sets first time talker variable so first time conversation does not happen again.
// Jonas final variant

void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "nLast"+GetTag(OBJECT_SELF), 1);
}

