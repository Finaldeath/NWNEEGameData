// March 2006
// B W-Husey
// Version of standard variable when the option is opened up for ever after the variable is set (i.e.
// opposite of standard). This is used on Jonas in conjunction with nFree to determine whether he is
// free of the ring

int StartingConditional()
{
    string sName = "Var1"+GetTag(OBJECT_SELF);       //Set variable to object's tag + extra bit
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    if(nOnce==TRUE && GetLocalInt(OBJECT_SELF,"nFree")<1)
        {
        return TRUE;
        }
    return FALSE;     //do not allow this conversation branch if done before
}


