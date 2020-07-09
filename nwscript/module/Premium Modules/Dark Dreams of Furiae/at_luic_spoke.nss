// Flags Luicil as having been spoken to today.

void main()
{
    SetLocalInt(GetModule(), "ddf_luic_met", TRUE);
    SetLocalInt(GetModule(), "ddf_luic_spoke", TRUE);
}
