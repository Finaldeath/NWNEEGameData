//the harpers leave for good
void main()
{
    //despawn the harpers from the inn
    object oDrelia = GetObjectByTag("db_drelia");
    object oBrenda = GetObjectByTag("db_brenda");
    object oMeyhew = GetObjectByTag("db_meyhew");
    DelayCommand(1.5,DestroyObject(oDrelia));
    DelayCommand(1.5,DestroyObject(oBrenda));
    DelayCommand(1.5,DestroyObject(oMeyhew));
    //pc chooses neither Harpers nor Sememmon
    SetLocalInt(GetModule(),"good_evil",3);
}
