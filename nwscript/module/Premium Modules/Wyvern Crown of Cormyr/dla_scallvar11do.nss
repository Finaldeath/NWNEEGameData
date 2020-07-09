
//April 2004
// B W-Husey
// Version of standard variable when the option is opened up for ever after the variable is set (i.e.
// opposite of standard).

int StartingConditional()
{
    string sName = "Var11"+GetTag(OBJECT_SELF);       //Set variable to object's tag + extra bit
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    if(nOnce==TRUE)
        {
        return TRUE;
        }
    return FALSE;     //do not allow this conversation branch if done before
}


