// June 2003
// B W-Husey
// Sets first time talker variable so first time conversation does not happen again.
// Generic - use on action taken of first conversation for any character. This is NOT
// partywide (use number 2 if you want partywide)

void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "nFirst"+GetTag(OBJECT_SELF), 1);
}

