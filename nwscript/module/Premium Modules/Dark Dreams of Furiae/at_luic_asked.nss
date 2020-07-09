#include "ddf_util"
// Sets flag that the player asked Luicil for information today.

void main()
{
    debug("-- Setting ddf_luic_asked = TRUE");
    SetLocalInt(GetModule(), "ddf_luic_asked", TRUE);
}
