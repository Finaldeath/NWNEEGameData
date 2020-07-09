
//September 2005
// B W-Husey
// PC asks a question that he cannot ask again.
// These generic scripts must ONLY be used once per character, and never for multiple option variables
// This variable automatically switches its own state so no other script is required
// Note on the conversation root comments what each variable has been use for.
// Londro Sidequest variable >2 and <9, quest has been taken and the Matron spoken to.
// Londro is still in the pub.
int StartingConditional()
{
    string sName = "Var5"+GetTag(OBJECT_SELF);       //Set variable to object's tag + extra bit
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    if(nOnce==FALSE)
        {
        // Inspect local variables
        if(GetLocalInt(GetPCSpeaker(), "LondroSide") > 2 && GetLocalInt(GetPCSpeaker(), "LondroSide") < 9)
            return TRUE;
        }
    return FALSE;     //do not allow this conversation branch if done before
}

