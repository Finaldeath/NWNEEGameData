void main()
{
    //set up an int for jemmy's conversation
    if(GetLocalInt(GetModule(),"jemmy_wrapup")==2)
    {
        SetLocalInt(GetModule(),"jemmy_wrapup", 3);
    }
}
