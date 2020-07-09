//April 2004
// B W-Husey
// PC asks a question that he cannot ask again.
// These generic scripts must ONLY be used once per character, and never for multiple option variables
// This variable automatically switches its own state so no other script is required
// Note on the conversation root comments what each variable has been use for.

// HAwklin version - added a plot state check of >5

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC,"nMainPlot")<6) return FALSE; // Don't continue if too early in plot

    string sName = "Var12"+GetTag(OBJECT_SELF);       //Set variable to object's tag + extra bit
    int nOnce = GetLocalInt(oPC, sName);  //Check to see if PC has tried this before
    if(nOnce==FALSE)
        {
        return TRUE;
        }
    return FALSE;     //do not allow this conversation branch if done before
}


