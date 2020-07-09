// (If you have killed anyone outside of Aladara's basement, Ulan's warehouse, Rathole, and the Soul Trade Inn)

#include "ddf_util"

int StartingConditional()
{
    if(HasKilledInPublic() == FALSE) return FALSE;
    return TRUE;
}
