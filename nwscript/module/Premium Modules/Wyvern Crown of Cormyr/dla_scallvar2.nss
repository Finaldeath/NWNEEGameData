
//April 2004
// B W-Husey
// PC asks a question that he cannot ask again.
// These generic scripts must ONLY be used once per character, and never for multiple option variables
// Note on the conversation root comments what each variable has been use for.

int StartingConditional()
{
    string sName = "Var2"+GetTag(OBJECT_SELF);       //Set variable to object's tag + extra bit
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    if(nOnce==FALSE)
        {
        return TRUE;
        }
    return FALSE;     //do not allow this conversation branch if done before
}


