#Include "TOTVS.ch"

User Function Finsu()

	Local aArea := GetArea()
	Local cUser := GetNewPar("FS_USRNSU","")
	Private cGet  := "            "
	Private lHasButton := .T.
	SetPrvt("oDlg1","oSay1","oBtn1","oBtn2","oGet1")


	If !(RetCodUsr() $ cUser)
		Alert("O usuário não tem permissão para acessar essa rotina. Entre em contato com o administrador do sistema!")
	Elseif AllTrim(SE1->E1_NSUTEF) != ""
		Alert("Este título já possui NSU cadastrado.")
	Else
		oDlg1      := MSDialog():New( 092,232,229,465,"Inserir NSU",,,.F.,,,,,,.T.,,,.T. )
		oSay1      := TSay():New( 012,008,{||"NSU"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
		oBtn1      := TButton():New( 032, 060, "Fechar",oDlg1,{||oDlg1:End()}, 037,012,,,.F.,.T.,.F.,,.F.,,,.F. )
		oBtn2      := TButton():New( 032, 012, "Inserir",oDlg1,{||fInsert()}, 037,012,,,.F.,.T.,.F.,,.F.,,,.F. )
		oGet1      := TGet():New( 012, 024, { | u | If( PCount() == 0, cGet, cGet := u ) },oDlg1, ;
			060, 0008, "!@",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"cGet",,,,lHasButton  )
		oDlg1:Activate(,,,.T.)
	EndIf

	RestArea(aArea)
Return


Static Function fInsert()

	Reclock("SE1",.F.)
	SE1->E1_NSUTEF := cGet
	MsUnLock()
	oDlg1:End()
Return
