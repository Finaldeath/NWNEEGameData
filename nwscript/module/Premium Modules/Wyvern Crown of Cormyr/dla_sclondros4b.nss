//B W-Husey
// September 2005
// Londro Sidequest variable = 4, convinced Matron (verbal).
// Modified version also checks this has been asked before.

int StartingConditional()
{
    string sName = "Var7"+GetTag(OBJECT_SELF);       //Set variable to object's tag + extra bit
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    if(nOnce==TRUE)
        {
        return FALSE;
        }
    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "LondroSide") == 4)
        return TRUE;

    return FALSE;
}
