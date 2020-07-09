// STANDARD VARIABLE
//April 2004
// B W-Husey
// PC starts this dialogue while the variable remains unset.
// These generic scripts must ONLY be used once per character
// They must be switched to a new state in another script
// Note on the conversation root comments what each variable has been used for.

int StartingConditional()
{
    string sName = "Stan2"+GetTag(OBJECT_SELF);      //Set variable to object's tag + extra bit
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    if(nOnce==FALSE)
        {
        return TRUE;
        }
    return FALSE;     //do not allow this conversation branch if done before
}


