// Flags Forvor as having been spoken to today.

void main()
{
    SetLocalInt(GetModule(), "ddf_forv_met", TRUE);
    SetLocalInt(GetModule(), "ddf_forv_spoke", TRUE);
}
