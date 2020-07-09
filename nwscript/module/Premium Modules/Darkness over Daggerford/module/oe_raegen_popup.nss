//if a player walks over the trigger run the henchman interject routine

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        ExecuteScript("hf_tu_henchman", OBJECT_SELF);
    }
}
