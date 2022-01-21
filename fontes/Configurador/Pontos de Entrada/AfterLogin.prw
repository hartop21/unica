#include 'TOTVS.ch'

User Function AfterLogin()
	Local aDicionarios := RetSxs()
	FwMsgRun(, { || aEVal(aDicionarios, {|x| DbSelectArea(x[1])}) }, , "Preparando ambiente..."  )

	If FwIsAdmin()
		SetKey( K_CTRL_F12,  {|| U_PXRUNPRG() } )
	EndIf
Return
