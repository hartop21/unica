#Include "TOTVS.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA030ROT  �Autor  � LUIZ OTAVIO CAMPOS  � Data �  21/08/21   ���
�������������������������������������������������������������������������͹��
���Desc.     � Tela para mostrar o saldo do Cashback no cadastro do client ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �protheus                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MA030ROT
    Local aRet := {} // Botoes a adicionar

    aAdd( aRet, { "Cashback", "U_UNIA033", 0, 2 } ) //Cadastro de Bancos


Return (aRet )

